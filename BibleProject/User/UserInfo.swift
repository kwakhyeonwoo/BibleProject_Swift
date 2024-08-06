//
//  UserInfo.swift
//  BibleProject
//
//  Created by 곽현우 on 8/5/24.
//


import SwiftUI
import Foundation

struct UserInfo: View {
    
    @State var nickName: String = ""
    @State var gender: Bool? = nil
    @State var height: String = ""
    @State var weight: String = ""
    @State var age: String = ""
    
    //Alert 표시 여부 제어하는 변수
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Image("Paris5")
            .resizable()
            .frame(height: 150)
            .clipShape(Circle())
            
            HStack(alignment: .center) {
                Text("닉네임: ")
                    .padding()
                TextField("닉네임", text: $nickName)
                    .padding()
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .onAppear() {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
            }
            .padding(.horizontal)
            
            HStack {
                Text("성별: ")
                    .padding()
                
                Button(action: {
                    self.gender = true
                }, label: {
                    Text("남성")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(self.gender == true ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                
                Button(action: {
                    self.gender = false
                }, label: {
                    Text("여성")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(self.gender == false ? Color.pink : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
            .padding(.horizontal)
            
            HStack {
                Text("키: ")
                    .padding()
                TextField("키", text: $height)
                    .keyboardType(.decimalPad)
                    .padding()
                    .onChange(of: height) {newValue in
                        if !newValue.allSatisfy({$0.isNumber || $0 == "."}){
                            showAlert = true
                            alertMessage = "숫자만 입력하세요!"
                            height = newValue.filter{$0.isNumber || $0 == "."}
                        }
                    }
            }
            .padding(.horizontal)
            
            HStack {
                Text("몸무게: ")
                    .padding()
                TextField("몸무게", text: $weight)
                    .keyboardType(.decimalPad)
                    .padding()
            }
            .padding(.horizontal)
            
            HStack {
                Text("나이: ")
                    .padding()
                TextField("나이", text: $age)
                    .keyboardType(.numberPad)
                    .padding()
            }
            .padding(.horizontal)
        }
        .padding()
        //showAlert가 true일 때 출력
        .alert(isPresented: $showAlert){
            Alert(title: Text("잘못된 입력"), message: Text(alertMessage),
                  dismissButton: .default(Text("확인"))
            )
        }
    }
}

#Preview {
    UserInfo()
}

