//
//  WebView.swift
//  wingsInterview
//
//  Created by cheshire on 1/10/24.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        // 여기서 필요한 경우 뷰 컨트롤러를 업데이트합니다.
    }
}
