//
//  InputFoodCalorie.swift
//  BibleProject
//
//  Created by 곽현우 on 8/10/24.
//

import SwiftUI

struct InputFoodCalorie : View {
    @State private var food : String = ""
    @State private var calorie : String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var nowCalorie : Int
    //현재 뷰 닫기 위해 설정
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        VStack{
            
            Group{
                HStack{
                    Spacer()
                    Text("음식: ")
                        .frame(width: 80, alignment: .leading)
                    TextField("음식", text: $food)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .onAppear(){
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                    Spacer()
                }
                HStack{
                    Spacer()
                    Text("칼로리: ")
                        .frame(width: 80, alignment: .leading)
                    TextField("칼로리", text: $calorie)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .onAppear(){
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                        .onChange(of: calorie) { cal in
                            if !cal.allSatisfy({ $0.isNumber || $0 == "."
                                }){
                                    showAlert = true
                                    alertMessage = "숫자만 입력해주세요"
                                    calorie = cal.filter {$0.isNumber || $0 == "."}
                                }
                        }
                    Spacer()
                }
                
                Button(action: {
                    if let calorieInt = Int(calorie){
                        nowCalorie += calorieInt
                    }
                    //현재 뷰 닫고 부모 뷰로 이동
                    self.presentationMode.wrappedValue.dismiss()
                    
                }){
                    Text("추가")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}

//#Preview {
//    InputFoodCalorie()
//}
