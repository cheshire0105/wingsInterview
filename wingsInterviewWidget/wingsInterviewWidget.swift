//
//  wingsInterviewWidget.swift
//  wingsInterviewWidget
//
//  Created by cheshire on 1/10/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), question: nil)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, question: nil)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        let questions = fetchQuestionsFromAppGroup()
        let currentDate = Date()

        for secondOffset in stride(from: 0, to: 5 * 30, by: 30) {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: currentDate)!
            let randomQuestion = randomQuestion(from: questions)
            let entry = SimpleEntry(date: entryDate, configuration: configuration, question: randomQuestion)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }



    private func fetchQuestionsFromAppGroup() -> [InterviewQuestion] {
        if let userDefaults = UserDefaults(suiteName: "group.com.cheshire0105.wingsInterview") {
            let decoder = JSONDecoder()
            if let questionsData = userDefaults.data(forKey: "InterviewQuestions") {
                print("Fetched Data: \(questionsData)")
                if let questions = try? decoder.decode([InterviewQuestion].self, from: questionsData) {
                    print("Decoded Questions: \(questions)")
                    return questions
                } else {
                    print("Failed to decode questions")
                }
            } else {
                print("No questions data found")
            }
        }
        return []
    }

    private func randomQuestion(from questions: [InterviewQuestion]) -> InterviewQuestion? {
        guard !questions.isEmpty else { return nil }
        return questions.randomElement()
    }



}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let question: InterviewQuestion? // 서버에서 가져온 질문 추가
}


struct wingsInterviewWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            if let question = entry.question, let firstQA = question.questions.first {
                Text(firstQA.question)
                    .foregroundColor(Color("MainPageCellTextColor")) // Assets에서 정의된 텍스트 색상 사용

                Text("\n")
                Text(firstQA.answer)
                    .foregroundColor(Color("MainPageCellTextColor")) // Assets에서 정의된 텍스트 색상 사용

                Text("\n")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 최대 너비와 높이 설정
        .background(Color("BackColor")) // 배경색 적용
        .edgesIgnoringSafeArea(.all) // 모든 가장자리를 무시하고 배경색 적용
    }
}




struct wingsInterviewWidget: Widget {
    let kind: String = "wingsInterviewWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            wingsInterviewWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }

    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    wingsInterviewWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, question: nil)
    SimpleEntry(date: .now, configuration: .starEyes, question: nil)
}

import Foundation

struct InterviewQuestion: Codable {
    var documentName: String
    var questions: [QuestionAnswer]
}

struct QuestionAnswer: Codable {
    var question: String
    var answer: String
}
