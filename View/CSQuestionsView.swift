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
                List(viewModel.questions) { questionItem in
                    NavigationLink(destination: QuestionDetailView(question: questionItem.question, answer: questionItem.answer)) {
                        Text(questionItem.question)
                    }
                    .listRowBackground(Color("BackColor"))
                }
                .listStyle(PlainListStyle())
                Spacer()
            }
            .navigationTitle("CS 면접 질문")
        }
    }
}
