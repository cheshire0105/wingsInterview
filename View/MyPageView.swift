//
//  SearchView.swift
//  wingsInterview
//
//  Created by cheshire on 1/9/24.
//
import Foundation
import SwiftUI

struct MyPageView: View {
    @ObservedObject var viewModel = MyPageViewModel()
    @State private var showWebView = false
    @State private var selectedURL: URL?

    var body: some View {
        ZStack {
            Color("BackColor").edgesIgnoringSafeArea(.all)

            VStack(alignment: .center, spacing: 20) {
                // 프로필 이미지
                if let imageURL = URL(string: viewModel.userProfile.profileImageURL) {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                }

                HStack {
                    // 홈페이지 버튼
                    Button(action: {
                        self.selectedURL = URL(string: "https://www.google.com")
                        self.showWebView = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 2초 후에 사용자의 홈페이지로 이동
                            self.selectedURL = URL(string: viewModel.userProfile.homepageURL)
                        }
                    }) {
                        Image(systemName: "house.fill")
                    }

                    // 블로그 버튼
                    Button(action: {
                        self.selectedURL = URL(string: viewModel.userProfile.blogURL)
                        self.showWebView = true
                    }) {
                        Image(systemName: "book.fill")
                    }

                    // 이메일 버튼 (이메일의 경우 메일 앱 열기)
                    Button(action: {
                        if let url = URL(string: "mailto:\(viewModel.userProfile.emailAddress)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Image(systemName: "envelope.fill")
                    }
                }
            }
        }
        .sheet(isPresented: $showWebView) {
            if let url = selectedURL {
                WebView(url: url)
            }
        }
        .onAppear {
            viewModel.fetchProfileData()
        }
    }
}




// 프리뷰 구조체
struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}




