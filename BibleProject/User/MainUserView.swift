//
//  MainUserView.swift
//  BibleProject
//
//  Created by 곽현우 on 8/10/24.
//

import SwiftUI

struct MainUserView: View {
    @ObservedObject var user: StateUserModel
    @State private var todayCalorie: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 110) {
                Spacer() // 윗부분에 Spacer 추가하여 중앙 배치

                VStack(alignment: .center, spacing: 16) {
                    NavigationLink(destination: InputFoodCalorie()) {
                        Image("Paris5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 250)
                    }
                    
                    Text("\(user.nickName)님 반갑습니다")
                    
                    HStack {
                        Text("오늘의 칼로리: ")
                        TextField("오늘의 칼로리 입력", text: $todayCalorie)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: todayCalorie) { calorie in
                                if !calorie.allSatisfy({ $0.isNumber || $0 == "." }) {
                                    showAlert = true
                                    alertMessage = "숫자만 입력해주세요"
                                    todayCalorie = calorie.filter { $0.isNumber || $0 == "." }
                                }
                            }
                    } // HStack
                    
                    Button(action: {
                        SuggestCal()
                    }) {
                        Text("나의 권장 칼로리 확인하기")
                    }
                    .padding()
                }
                .padding()

                Spacer() // 하단에 Spacer 추가하여 중앙 배치

                ZStack{
                    TabView {
                        Text("First")
                            .hidden()
                            .tabItem {
                                Image(systemName: "calendar")
                                Text("Calendar")
                            }
                        Text("Second")
                            .hidden()
                            .tabItem {
                                Image(systemName: "2.square.fill")
                                Text("Home")
                            }
                        Text("Third")
                            .hidden()
                            .tabItem {
                                Image(systemName: "person.fill")
                                Text("MyPage")
                            }
                    }
                    .font(.headline)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("\(user.nickName)의 권장 칼로리는"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
        }
    }

    func SuggestCal() {
        let heightValue = Double(user.height) ?? 0
        var recommendedCalories: String
        
        if user.gender == true {
            recommendedCalories = String(format: "%.0f", (heightValue - 100) * 0.9 * 33)
        } else if user.gender == false {
            recommendedCalories = String(format: "%.0f", (heightValue - 90) * 0.9 * 33)
        } else {
            recommendedCalories = "성별이 설정되지 않았습니다."
        }
        
        alertMessage = "권장 칼로리는 \(recommendedCalories)입니다."
        showAlert = true
    }
}

#Preview {
    MainUserView(user: StateUserModel())
}
