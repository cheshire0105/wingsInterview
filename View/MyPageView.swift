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
    @State private var selectedURL: URL?
    @State private var showSafariView = false


    var body: some View {

        NavigationView { // NavigationView 추가

            ZStack {
                Color("BackColor").edgesIgnoringSafeArea(.all)

                HStack(spacing: 30) {
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

                    VStack(alignment: .leading, spacing: 20) {
                        // 홈페이지 버튼
                        Button(action: {
                            self.showSafariView = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.selectedURL = URL(string: viewModel.userProfile.homepageURL)
                            }
                        }) {
                            Text("Portfolio")
                                .font(.headline)
                                .foregroundColor(Color("MainPageCellTextColor"))
                        }

                        // 블로그 버튼
                        Button(action: {
                            self.selectedURL = URL(string: viewModel.userProfile.blogURL)
                            self.showSafariView = true
                        }) {
                            Text("블로그")
                                .font(.headline)
                                .foregroundColor(Color("MainPageCellTextColor"))
                        }

                        // 이메일 버튼
                        Button(action: {
                            if let url = URL(string: "mailto:\(viewModel.userProfile.emailAddress)") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("메일 보내기")
                                .font(.headline)
                                .foregroundColor(Color("MainPageCellTextColor"))
                        }
                    }
                }
                .navigationTitle("제작자")
            }
        }
        .fullScreenCover(isPresented: $showSafariView, content: {
            if let url = selectedURL {
                SafariView(url: url)
            }
        })
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




