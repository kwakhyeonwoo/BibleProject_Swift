import SwiftUI

// 첫 번째 페이지 뷰: 앱 시작 시 나타나는 첫 페이지
struct FirstPageView: View {
    @State private var navigateToNextPage = false // 페이지 전환 상태 저장 변수

    var body: some View {
        VStack {
            if navigateToNextPage {
                // 페이지 전환 상태가 true일 때, 두 번째 페이지를 표시
                SecondPageView()
            } else {
                // 페이지 전환 상태가 false일 때, 첫 번째 페이지의 내용 표시
                VStack {
                    // 앱 아이콘 이미지 (시스템 아이콘을 사용)
                    Image(systemName: "app.fill")
                        .resizable() // 이미지 크기 조절 가능
                        .aspectRatio(contentMode: .fit) // 비율에 맞게 조절
                        .frame(width: 100, height: 100) // 프레임 크기 설정
                        .padding(.top, 5) // 위쪽 여백

                    // 앱 이름 텍스트
                    Text("Stop Eat")
                        .font(.largeTitle) // 큰 글꼴 크기
                        .fontWeight(.bold) // 글꼴 두껍게
                        .padding(.top, 20) // 위쪽 여백 추가
                }
                .transition(.opacity) // 화면 전환 애니메이션 (투명도 변화)
                .onAppear {
                    // 화면이 나타날 때 3초 후에 페이지 전환 상태를 true로 설정
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            navigateToNextPage = true
                        }
                    }
                }
            }
        }
    }
}
