//
//  RealmCoopRecord.swift
//  Salmonia3+
//
//  Created by devonly on 2024/04/19
//  Copyright © 2024 Magi Corporation. All rights reserved.
//

import Foundation
import RealmSwift
import Thunder

final class RealmCoopRecord: Object, Identifiable {
    /// ステージID
    @Persisted(primaryKey: true) var stageId: CoopStage.Id
    /// 開始時刻(ビッグランのみ)
    @Persisted var startTime: Date?
    /// 終了時刻(ビッグランのみ)
    @Persisted var endTime: Date?
    /// 最高評価
    @Persisted var grade: CoopGrade.Id?
    /// 最高評価ポイント
    @Persisted var gradePoint: Int?
    /// ランク(ビッグランのみ)
    @Persisted var rank: Int?
    /// トロフィー(ビッグランのみ)
    @Persisted var trophy: String?
    /// 最高納品数
    @Persisted var goldenIkuraNum: Int?
    /// バイト回数
    @Persisted var count: Int?
}
