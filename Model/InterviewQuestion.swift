//
//  InterviewQuestion.swift
//  wingsInterview
//
//  Created by cheshire on 1/9/24.
//

import Foundation

struct InterviewQuestion: Encodable, Identifiable {
    let id = UUID() // 각 인스턴스에 대해 유일한 ID 생성

    var documentName: String
    var questions: [QuestionAnswer]
}

struct QuestionAnswer: Encodable {
    var question: String
    var answer: String
}
