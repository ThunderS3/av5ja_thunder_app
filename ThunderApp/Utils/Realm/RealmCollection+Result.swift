//
//  RealmCollection+Result.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/13.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import RealmSwift
import Thunder

extension RealmCollection where Element == RealmCoopResult {
    /// スケジュールでの各ウロコ枚数
    var scales: [Int] {
        map({ $0.scale.map({ $0 ?? 0 }) }).sum()
    }
    
    /// スケジュールでの最大評価
    var maxGradeId: CoopGrade.Id? {
        max(ofProperty: "gradeId")
    }

    /// スケジュールでの最大評価ポイント
    var maxGradePoint: Int? {
        guard let maxGradeId: CoopGrade.Id = maxGradeId else { return nil }
        return filter("gradeId = %@", maxGradeId).max(ofProperty: "gradePoint")
    }
    
    /// スケジュールでの平均クリアWAVE
    var averageClearedWaves: Double? {
        isEmpty ? nil : 3.0 - Double(compactMap(\.failureWave).map({ 4 - $0 }).sum()) / Double(count)
    }
    
    /// 回線落ちを除くクリア率
    var clearRatio: Double? {
        if isEmpty { return nil }
        return Double(wavesCount(exWave: false)) / Double(filter("failureWave!=-1").count * 3)
    }
    
    /// 合計WAVE数
    private func wavesCount(exWave: Bool) -> Int {
        exWave ? map(\.waves.count).sum() : map({ Swift.min(3, $0.waves.count) }).sum()
    }
}
