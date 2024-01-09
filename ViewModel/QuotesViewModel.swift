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
                return
            }
            guard let document = document, document.exists, let data = document.data() else {
                print("Document does not exist")
                return
            }
            DispatchQueue.main.async {
                self.quotes = data.compactMap { (key, value) -> Quote? in
                    if let quoteArray = value as? [String], quoteArray.count == 2 {
                        return Quote(id: key, quote: quoteArray[0], name: quoteArray[1])
                    } else {
                        return nil // 잘못된 형식의 데이터는 무시
                    }
                }
            }
        }
    }
}
