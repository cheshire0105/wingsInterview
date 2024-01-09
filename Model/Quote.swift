//
//  Quote.swift
//  wingsInterview
//
//  Created by cheshire on 1/9/24.
//

import Foundation

struct Quote: Identifiable, Equatable {
    var id: String // 고유 식별자, 예를 들어 UUID를 사용할 수 있음
    var quote: String
    var name: String

    // Equatable 프로토콜을 준수하기 위한 구현
    static func == (lhs: Quote, rhs: Quote) -> Bool {
        return lhs.id == rhs.id // 또는 quote와 name을 비교하여 구현
    }
}

