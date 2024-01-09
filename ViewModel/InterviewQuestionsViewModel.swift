//
//  InterviewQuestionsViewModel.swift
//  wingsInterview
//
//  Created by cheshire on 1/9/24.
//

import Foundation
import FirebaseFirestore

class InterviewQuestionsViewModel: ObservableObject {
    @Published var questions = [InterviewQuestion]()

    private var db = Firestore.firestore()

    init() {
        fetchData()
    }

    func fetchData() {
        db.collection("ios").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else if let snapshot = snapshot {
                DispatchQueue.main.async {
                    self.questions = snapshot.documents.map { document in
                        let documentName = document.documentID
                        let questionAnswers = document.data().compactMap { (key, value) -> QuestionAnswer? in
                            if let answer = value as? String {
                                return QuestionAnswer(question: key, answer: answer)
                            }
                            return nil
                        }
                        return InterviewQuestion(documentName: documentName, questions: questionAnswers)
                    }
                }
            }
        }
    }

}
