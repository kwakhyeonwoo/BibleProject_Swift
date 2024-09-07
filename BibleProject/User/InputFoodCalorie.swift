//
//  InputFoodCalorie.swift
//  BibleProject
//
//  Created by 곽현우 on 8/10/24.
//

import SwiftUI

struct InputFoodCalorie : View {
    @State private var food : String = ""
    @State private var gym : String = ""
    @State private var calorie : String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showFoodInput : Bool = false
    @State private var delFoodInput : Bool = false
    @Binding var nowCalorie : Int
    //현재 뷰 닫기 위해 설정
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        HStack(spacing: 30){
            Button(action: {
                withAnimation(nil){
                    self.showFoodInput = true
                    self.delFoodInput = false
                }
            }){
                Text("음식 추가")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            
           Button(action: {
               withAnimation(nil){
                   self.showFoodInput = false
                   self.delFoodInput = true
               }
           }){
               Text("소모 칼로리")
                   .padding()
                   .background(Color.blue)
                   .foregroundColor(.white)
                   .cornerRadius(10)
           }
        }
        
        if showFoodInput {
            VStack{
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
                    TextField("섭취한 칼로리", text: $calorie)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .onAppear(){
                            UITextField.appearance().clearButtonMode = .whileEditing
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
            .padding()
        } else if delFoodInput {
            VStack{
                HStack{
                    Spacer()
                    Text("운동: ")
                        .frame(width: 80, alignment: .leading)
                    TextField("운동 종류", text: $gym)
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
                    Text("칼로리")
                        .frame(width: 80, alignment: .leading)
                    TextField("소모한 칼로리", text: $calorie)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .onAppear(){
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                    Spacer()
                }
                
                Button(action: {
                    if let delCal = Int(calorie){
                        nowCalorie -= delCal
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("추가")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }// else if
        
    }
}

//#Preview {
//    InputFoodCalorie(nowCalorie: $nowCalorie)
//}
