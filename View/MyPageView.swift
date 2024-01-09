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
                        self.selectedURL = URL(string: viewModel.userProfile.homepageURL)
                        self.showWebView = true
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

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}



// 프리뷰 구조체
struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}


struct UserProfile {
    var profileImageURL: String
    var homepageURL: String
    var blogURL: String
    var emailAddress: String
}

import FirebaseFirestore
import FirebaseStorage


class MyPageViewModel: ObservableObject {
    @Published var userProfile = UserProfile(profileImageURL: "", homepageURL: "", blogURL: "", emailAddress: "")

    func fetchProfileData() {
        let db = Firestore.firestore()

        // Firestore에서 프로필 정보 가져오기
        db.collection("내_정보").document("프로필").getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                DispatchQueue.main.async {
                    self?.userProfile.homepageURL = data?["홈페이지_주소"] as? String ?? ""
                    self?.userProfile.blogURL = data?["블로그_주소"] as? String ?? ""
                    self?.userProfile.emailAddress = data?["이메일_주소"] as? String ?? ""
                }
            } else {
                print("Document does not exist")
            }
        }
        
        // Storage에서 이미지 URL 가져오기
        let storageRef = Storage.storage().reference().child("image2.jpeg")
        storageRef.downloadURL { [weak self] (url, error) in
            guard let downloadURL = url else {
                print("Image download URL not found")
                return
            }
            DispatchQueue.main.async {
                self?.userProfile.profileImageURL = downloadURL.absoluteString
            }
        }
    }
}
