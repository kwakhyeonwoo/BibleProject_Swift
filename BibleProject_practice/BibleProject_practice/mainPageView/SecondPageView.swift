import SwiftUI

// 두 번째 페이지 뷰: 로그인 및 회원가입 페이지
struct SecondPageView: View {
    @State private var id: String = "" // 사용자 ID 입력 값
    @State private var password: String = "" // 사용자 비밀번호 입력 값

    var body: some View {
        VStack(spacing: 0.5) { // 위아래 간격을 0.5 포인트
            Spacer() // 중앙 정렬

            VStack(spacing: 20) { // ID와 비밀번호 필드 사이 간격
                // 사용자 ID 입력 필드
                TextField("ID", text: $id)
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // 둥근 테두리 스타일
                    .padding(.horizontal) // 좌우 여백
                    .frame(maxWidth: .infinity) // 폭

                // 사용자 비밀번호 입력 필드
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // 둥근 테두리 스타일
                    .padding(.horizontal) // 좌우 여백
                    .frame(maxWidth: .infinity) // 폭
            }
            .padding(.horizontal) // 전체적으로 좌우 여백
            
            HStack(spacing: 20) { // 버튼 사이의 간격
                // 로그인 버튼
                Button(action: {
                    // 로그인 버튼 클릭 시의 동작
                }) {
                    Text("로그인")
                        .font(.subheadline) // 작은 글꼴 크기
                        .padding(10) // 내부 여백 조정
                        .frame(width: 140, height: 40) // 버튼 폭과 높이 조정
                        .background(Color.clear) // 투명 배경
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1) // 테두리 색상 및 두께
                        )
                        .cornerRadius(8) // 모서리 둥글게
                }
                .padding(.top, 10) // 버튼과 ID 필드 사이의 여백

                // 회원가입 버튼
                Button(action: {
                    // 회원가입 버튼 클릭 시의 동작
                }) {
                    Text("회원가입")
                        .font(.subheadline) // 작은 글꼴 크기
                        .padding(10) // 내부 여백 조정
                        .frame(width: 140, height: 40) // 버튼 폭과 높이 조정
                        .background(Color.clear) // 투명 배경
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1) // 테두리 색상 및 두께
                        )
                        .cornerRadius(8) // 모서리 둥글게
                }
                .padding(.top, 10) // 버튼과 ID 필드 사이 여백
            }
            .padding(.horizontal) // 버튼의 좌우 여백

            Spacer() // 아래쪽 여백
        }
        .padding() // 전체 여백
        .navigationBarHidden(true) // 네비게이션 타이틀 숨기기
    }
}
