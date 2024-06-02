//
//  RealmManager.swift
//  Salmonia3+
//
//  Created by devonly on 2023/12/04
//  Copyright © 2023 Magi Corporation. All rights reserved.
//

import Foundation
import RealmSwift
import SplatNet3
import SwiftUI
import Raccoon

internal final class RealmManager: Session {
    override private init() { super.init() }

    static let `shared`: RealmManager = .init()

    private var realm: Realm { try! Realm(configuration: RealmMigration.configuration) }

    func getCoopHistoryDetails() async throws {
        try await getWeaponRecord()
        try await getCoopRecord()
        try await getCoopSchedules()
        try await getCoopHistories()
    }

    @discardableResult
    override func getWeaponRecord() async throws -> WeaponRecordQuery.Response {
        let response: WeaponRecordQuery.Response =  try await super.getWeaponRecord()
        try await Raccoon.fetch(urls: response.assetURLs)
        return response
    }

    @discardableResult
    /// レコード更新
    /// - Returns:
    override func getCoopRecord() async throws -> CoopRecordQuery.Response {
        let response: CoopRecordQuery.Response = try await super.getCoopRecord()
        try await Raccoon.fetch(urls: response.assetURLs)
        try inWriteTransaction(transaction: {
            response.enemyRecords.forEach({ enemy in realm.update(RealmCoopEnemy.self, value: enemy, update: .modified)
                })
            response.stageRecords.forEach({ stage in
                // 記録がなかったら更新する
                if realm.object(ofType: RealmCoopRecord.self, forPrimaryKey: stage.stageId) == nil {
                    realm.update(RealmCoopRecord.self, value: stage, update: .modified)
                }
            })
        })
        return response
    }

    @discardableResult
    /// スケジュール更新
    /// - Returns:
    override func getCoopSchedules() async throws -> StageScheduleQuery.Response {
        let response: StageScheduleQuery.Response = try await super.getCoopSchedules()
        try inWriteTransaction(transaction: {
            response.schedules.forEach({ schedule in
                realm.update(RealmCoopSchedule.self, value: schedule, update: .modified)
            })
        })
        return response
    }

    @discardableResult
    /// スケジュール更新
    /// - Parameter playTime: 時刻
    /// - Returns:
    override func getCoopHistories(playTime: Date = .init(timeIntervalSince1970: 0)) async throws
    -> CoopResultQuery.Response {
        try await inTryRequest(action: {
            let response: CoopResultQuery.Response = (try await super.getCoopHistories(playTime: lastPlayedTime))
            let results: [CoopHistoryDetailQuery.Response] = response.histories.flatMap(\.results)
//            let assetURLs: [URL] = response.results.flatMap({ $0.assetURLs ?? [] })
//            try await Raccoon.fetch(urls: assetURLs)
            try inWriteTransaction(transaction: {
                results.forEach({ result in
                    // スケジュール作成
                    let schedule: RealmCoopSchedule = realm.update(
                        RealmCoopSchedule.self,
                        value: result.schedule,
                        update: .modified
                    )
                    let result: RealmCoopResult = result.object
                    realm.add(result, update: .modified)
                    // スケジュールの中にリザルトがなければ追加する
                    if !schedule.results.contains(result) { schedule.results.append(result) }
                })
            })
            try inWriteTransaction(transaction: {
                CoopStage.Id.allCases.forEach({ stageId in
                    if let newValue: Int = results.filter({ $0.schedule.stageId == stageId }).map(\.goldenIkuraNum)
                        .max(),
                        let record: RealmCoopRecord = realm.object(ofType: RealmCoopRecord.self, forPrimaryKey: stageId) {
                        let oldValue: Int = record.goldenIkuraNum ?? 0
                        if oldValue < newValue {
                            SwiftyLogger.verbose("Record update!")
                            record.goldenIkuraNum = newValue
                        }
                    }
                })
            })
            return response
        })
    }

    var lastPlayedTime: Date {
        let playTime: Date? = realm.objects(RealmCoopResult.self).max(ofProperty: "playTime")
        return playTime ?? .init(timeIntervalSince1970: 0)
    }

    func save(_ schedules: StageScheduleQuery.Response) {}

    func save(_ results: [CoopHistoryDetailQuery.Response]) throws {
        try inWriteTransaction(transaction: {
            results.map(\.object).forEach({ result in realm.add(result, update: .modified) })
        })
    }

    func remove() {
        do { try inWriteTransaction(transaction: { realm.deleteAll() }) } catch {
            //            SwiftyLogger.error(error)
        }
    }

    @MainActor private func inTryRequest<T: Codable>(action: () async throws -> T) async throws -> T {
        do { return try await action() } catch {
            if let error: SPError = error.asSPError {
                switch error {
                case .Token(let reason):
                    switch reason {
                    case .Expired:
                        await UIApplication.shared.open(URL(unsafeString: "mudmouth://capture?name=Salmonia3+"))
                    default: throw error
                    }
                default: throw error
                }  //                SwiftyLogger.error(error)
            }
            throw error
        }
    }

    private func inWriteTransaction(transaction writeBlock: () throws -> Void) throws {
        if realm.isInWriteTransaction {
            try writeBlock()
        } else {
            realm.beginWrite()
            try writeBlock()
            try realm.commitWrite()
        }
    }
}
