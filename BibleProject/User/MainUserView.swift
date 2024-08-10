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
                    Text("권장 칼로리")
                }
                
            }
        }
        
        
    }
    func SuggestCal() {
        if (user.gender == true) {
            let MansCal = (Double(user.height)!) - 100 * 0.9 * 33
        }
    }

}
#Preview {
    MainUserView(user: StateUserModel())
}
