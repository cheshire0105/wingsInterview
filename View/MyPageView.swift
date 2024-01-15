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
                        self.showSafariView = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 2초 후에 사용자의 홈페이지로 이동
                            self.selectedURL = URL(string: viewModel.userProfile.homepageURL)
                        }
                    }) {
                        Image(systemName: "house.fill")
                            .scaledToFit() // 아이콘 이미지의 원본 비율 유지
                    }

                    // 블로그 버튼
                    Button(action: {
                        self.selectedURL = URL(string: viewModel.userProfile.blogURL)
                        self.showSafariView = true
                    }) {
                        Image(systemName: "book.fill")
                            .scaledToFit() // 아이콘 이미지의 원본 비율 유지
                    }

                    // 이메일 버튼 (이메일의 경우 메일 앱 열기)
                    Button(action: {
                        if let url = URL(string: "mailto:\(viewModel.userProfile.emailAddress)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Image(systemName: "envelope.fill")
                            .scaledToFit() // 아이콘 이미지의 원본 비율 유지
                    }
                }
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
