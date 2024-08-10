//
//  MainUserView.swift
//  BibleProject
//
//  Created by 곽현우 on 8/10/24.
//

import SwiftUI

struct MainUserView: View {
    @ObservedObject var user: StateUserModel
    @State private var todayCalorie : String = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: InputFoodCalorie()){
                    Image("Paris5")
                        .resizable()
                        .frame(width: 150, height: 200)
                    
                }
                Text("\(user.nickName)님")
                
                HStack{
                    Text("오늘의 칼로리: ")
                        .padding()
                    TextField("오늘의 칼로리 입력", text: $todayCalorie)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: todayCalorie){calorie in
                            if !calorie.allSatisfy({$0.isNumber || $0 == "."}){
                                showAlert = true
                                alertMessage = "숫자만 입력해주세요"
                                todayCalorie = calorie.filter{
                                    $0.isNumber || $0 == "."
                                }
                            }
                        }
                }//HStack
                
                Button(action: {
                    SuggestCal()
                }){
                    Text("나의 권장 칼로리 확인하기")
                }
                .padding()
            }
            .alert(isPresented: $showAlert){
                Alert(title: Text("\(user.nickName)의 권장 칼로리는"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
            
        }
        
        
    }
    func SuggestCal() {
            let heightValue = Double(user.height) ?? 0
            //입력 값 문자열로 저장
            var recommendedCalories: String
            
            if user.gender == true {
                recommendedCalories = String(format: "%.0f", (heightValue - 100) * 0.9 * 33)
            } else if user.gender == false {
                recommendedCalories = String(format: "%.0f", (heightValue - 90) * 0.9 * 33)
            } else { // 성별이 설정되지 않은 경우
                recommendedCalories = "성별이 설정되지 않았습니다"
            }
            
            alertMessage = "권장 칼로리는 \(recommendedCalories)입니다."
            showAlert = true
        }

}
#Preview {
    MainUserView(user: StateUserModel())
}
