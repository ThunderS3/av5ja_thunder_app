//
//  StageView.swift
//  ThunderApp
//
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Raccoon
import Thunder
import RealmSwift

struct StageView: View {
    @State private var selection: CoopRule = .REGULAR
    
    var body: some View {
        NavigationView(content: {
            TabView(
                selection: $selection,
                content: {
                    StageRecordView(allCases: CoopStage.Id.regular)
                        .padding(.horizontal)
                        .navigationBarTitleDisplayMode(.inline)
                        .tag(CoopRule.REGULAR)
                    StageRecordView(allCases: CoopStage.Id.bigRun)
                        .padding(.horizontal)
                        .navigationBarTitleDisplayMode(.inline)
                        .tag(CoopRule.BIG_RUN)
                })
            .navigationTitle(Text(LocalizedType.RecordStageRecord))
            .tabViewStyle(.page)
        })
    }
    
    private struct StageRecordView: View {
        @ObservedResults(RealmCoopRecord.self, sortDescriptor: SortDescriptor(keyPath: "stageId", ascending: true)) var records
        let allCases: [CoopStage.Id]
        
        var body: some View {
            ScrollView(content: {
                LazyVGrid(columns: .init(repeating: .init(.flexible()), count: 2), content: {
                    ForEach(records.filter({ allCases.contains($0.stageId) }), content: { record in
                        StageView(record: record)
                    })
                })
            })
        }
    }
    
    private struct StageView: View {
        @State private var isPresented = false
        let record: RealmCoopRecord
        
        var body: some View {
            Button(action: {
                isPresented.toggle()
            }, label: {
                SPImage(record.stageId).scaledToFill()
            })
            .overlay(alignment: .topTrailing, content: {
                HStack(spacing: 4, content: {
                    SPImage(Media.SP2.PNG.GolenIkura)
                        .scaledToFit()
                        .frame(height: 14)
                    Text(record.goldenIkuraNum, format: .number())
                        .font(.custom(.Splatfont2, size: 16))
                })
                .padding(.horizontal, 4)
                .background(content: {
                    Color.black
                })
                .clipShape(RoundedRectangle(cornerRadius: 8))
            })
            .overlay(
                alignment: .bottomTrailing,
                content: {
                    Text(record.gradePoint, format: .number())
                        .font(.custom(.Splatfont2, size: 16))
                        .padding(.horizontal, 8)
                        .background(content: {
                            Color.black
                        })
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                })
            .clipShape(RoundedRectangle(cornerRadius: 8))
            //            .sheet(isPresented: $isPresented, content: {
            //                StageDetailView(record: record)
            //            })
        }
    }
}

#Preview {
    StageView()
}
