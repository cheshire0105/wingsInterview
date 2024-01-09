//
//  InterviewQuestionsView.swift
//  wingsInterview
//
//  Created by cheshire on 1/9/24.
//

import Foundation
import SwiftUI

struct InterviewQuestionsView: View {
    @ObservedObject var viewModel = InterviewQuestionsViewModel()

    var body: some View {
        ZStack {
            Color("BackColor").edgesIgnoringSafeArea(.all) // 전체 배경색

            VStack {
                Spacer()
                List(viewModel.questions) { questionItem in
                    NavigationLink(destination: QuestionDetailView(question: questionItem.question, answer: questionItem.answer)) {
                        Text(questionItem.question)
                    }
                    .listRowBackground(Color("BackColor")) // 리스트 각 행의 배경색
                }
                .listStyle(PlainListStyle())
                Spacer()
            }
            .navigationTitle("iOS 면접 질문")
        }
    }
}
