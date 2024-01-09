//
//  MyPageViewModel.swift
//  wingsInterview
//
//  Created by cheshire on 1/10/24.
//

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
