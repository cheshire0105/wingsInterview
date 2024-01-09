import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = QuotesViewModel()
    @State private var selectedTabIndex = 0 // 선택된 탭 인덱스 추적
    @State private var showInterviewQuestionsView = false
    @State private var showCSQuestionsView = false

    var body: some View {
        ZStack {
            Color("BackColor") // Assets에서 정의된 배경색 사용
                .edgesIgnoringSafeArea(.all) // Safe area를 무시하고 전체에 적용
            VStack {
                // 명언을 스와이프 가능한 탭 뷰로 표시
                TabView(selection: $selectedTabIndex) { // 선택된 탭 인덱스 바인딩
                    ForEach(viewModel.quotes.indices, id: \.self) { index in
                        Text("\(viewModel.quotes[index].quote)\n\n \(viewModel.quotes[index].name)")
                            .font(.custom("Pretendard-Medium", size: 16))
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 60, height: 160)
                            .background(Color("MainPageCellBackColor"))
                            .cornerRadius(10)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("MainPageCellTextColor")) // Assets에서 정의된 텍스트 색상 사용
                            .tag(index) // 각 탭에 대한 태그 설정

                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 250)
                .onChange(of: selectedTabIndex) { _ in // 탭 인덱스가 변경될 때
                    triggerHapticFeedback(style: .light)
                }


                // 컴포지셔널 레이아웃을 위한 그리드
                let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
                LazyVGrid(columns: gridItems, spacing: 20) {
                    // iOS 이미지 및 텍스트
                    Button(action: {
                        triggerHapticFeedback(style: .medium)
                        self.showInterviewQuestionsView = true
                    }) {
                        VStack {
                            Image(systemName: "iphone")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                            Text("iOS")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    .background(
                        NavigationLink(destination: InterviewQuestionsView(), isActive: $showInterviewQuestionsView) {
                            EmptyView()
                        }
                    )

                    // CS 이미지 및 텍스트
                    Button(action: {
                        triggerHapticFeedback(style: .medium)
                        self.showCSQuestionsView = true
                    }) {
                        VStack {
                            Image(systemName: "cpu")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                            Text("CS")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    .background(
                        NavigationLink(destination: CSQuestionsView(), isActive: $showCSQuestionsView) {
                            EmptyView()
                        }
                    )
                }

                Spacer()
            }
            .navigationTitle("Think Different!")

        }
    }

    func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




