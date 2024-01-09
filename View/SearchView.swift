//
//  SearchView.swift
//  wingsInterview
//
//  Created by cheshire on 1/9/24.
//

import Foundation
import SwiftUI

// 검색 페이지를 위한 뷰
struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator

        // UISearchBar 배경색 제거
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchBarStyle = .minimal // 이 옵션은 서치바의 스타일을 더 간결하게 만듭니다.

        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

// SearchView 수정
struct SearchView: View {
    @State private var searchText = ""

    var body: some View {

        ZStack {
            // 배경 색상 설정
            Color("BackColor") // Assets에서 정의된 배경색 사용
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.hideKeyboard() // 배경 탭 시 키보드 숨김
                }
            VStack {
                SearchBar(text: $searchText) // 검색 바 추가
                    .padding()
                Spacer()

            }
        }
    }

}

// UIView 확장: 모든 텍스트 입력 필드에서 키보드 숨기기
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


// 프리뷰 구조체
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
