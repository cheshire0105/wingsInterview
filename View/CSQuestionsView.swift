//
//  CSQuestionsView.swift
//  wingsInterview
//
//  Created by cheshire on 1/9/24.
//

import Foundation
import SwiftUI

struct CSQuestionsView: View {
    @ObservedObject var viewModel = CSQuestionsViewModel()

    var body: some View {
        ZStack {
            Color("BackColor").edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                List {
                    ForEach(viewModel.questions) { document in
                        Section(header: Text(document.documentName)
                            .foregroundColor(Color("MainPageCellTextColor")) // Assets에서 정의된 텍스트 색상 사용
                                    .listRowBackground(Color("BackColor"))) { // 섹션 헤더의 배경색
                            ForEach(document.questions, id: \.question) { qa in
                                NavigationLink(destination: QuestionDetailView(question: qa.question, answer: qa.answer)) {
                                    Text(qa.question)
                                        .foregroundColor(Color("MainPageCellTextColor")) // Assets에서 정의된 텍스트 색상 사용
                                }
                                .listRowBackground(Color("BackColor")) // 각 행의 배경색
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                Spacer()
            }
            .navigationTitle("CS")
        }
    }
}
