import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = QuotesViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color("BackColor") // Assets에서 정의된 배경색 사용
                    .edgesIgnoringSafeArea(.all) // Safe area를 무시하고 전체에 적용
                VStack {
                    // 명언을 스와이프 가능한 탭 뷰로 표시
                    TabView {
                        ForEach(viewModel.quotes) { quote in
                            Text("\(quote.quote)\n\n \(quote.name)")
                                .font(.system(size: 18))
                                .padding()
                                .frame(width: UIScreen.main.bounds.width - 60, height: 160)
                                .background(Color("MainPageCellBackColor"))
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("MainPageCellTextColor")) // Assets에서 정의된 텍스트 색상 사용

                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 250)

                    // 컴포지셔널 레이아웃을 위한 그리드
                    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
                    LazyVGrid(columns: gridItems, spacing: 20) {
                        // iOS 이미지 및 텍스트
                        NavigationLink(destination: InterviewQuestionsView()) {
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

                        // CS 이미지 및 텍스트
                        NavigationLink(destination: CSQuestionsView()) {
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
                    }

                    Spacer()
                }
                .navigationTitle("Think Different!")

            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




