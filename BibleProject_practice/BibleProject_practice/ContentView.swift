import SwiftUI

// ContentView: 첫 번째 페이지를 네비게이션 뷰로 감싸는 뷰
struct ContentView: View {
    var body: some View {
        NavigationView {
            FirstPageView() // 첫 번째 페이지 뷰를 네비게이션 뷰로 감싸서 표시
        }
    }
}
