//
//  QuestionDetailView.swift
//  wingsInterview
//
//  Created by cheshire on 1/9/24.
//

import Foundation
import SwiftUI


// 세부 질문-답변 페이지
struct QuestionDetailView: View {
    let question: String
    let answer: String

    var body: some View {
        ZStack {
            Color("BackColor") // Assets에서 정의된 배경색 사용
                .edgesIgnoringSafeArea(.all) // Safe area를 무시하고 전체에 적용

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(question)
                        .font(.title)
                        .fontWeight(.bold)
                        // 텍스트 프레임과 정렬 지정
                        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                        .padding(.leading, 17)
                        .padding(.trailing, 10)

                    Text(answer)
                        .font(.body)
                        // 텍스트 프레임과 정렬 지정
                        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                        .padding(.leading, 17)
                        .padding(.trailing, 10)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .navigationTitle("질문과 답변")
    }
}




