//
//  QuotesViewModel.swift
//  wingsInterview
//
//  Created by cheshire on 1/9/24.
//

import FirebaseFirestore

class QuotesViewModel: ObservableObject {
    @Published var quotes = [Quote]()

    private var db = Firestore.firestore()

    init() {
        fetchData()
    }

    func fetchData() {
        db.collection("명언").document("명언_상세").getDocument { (document, error) in
            if let error = error {
                print("Error getting document: \(error)")
            } else {
                if let document = document, document.exists {
                    let data = document.data() ?? [:]
                    DispatchQueue.main.async {
                        self.quotes = data.map { (key, value) in
                            if let quoteArray = value as? [String], quoteArray.count == 2 {
                                print("Quote Loaded: \(quoteArray[0]), by \(quoteArray[1])") // 콘솔에 출력
                                return Quote(quote: quoteArray[0], name: quoteArray[1])
                            } else {
                                return Quote(quote: "No quote available", name: "Unknown")
                            }
                        }
                    }
                }
            }
        }
    }
}
