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
    
    // Alert 표시 여부 제어하는 변수
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack (alignment:.center){
            Image("Paris5")
                .resizable()
                .frame(height: 150)
                .clipShape(Circle())
                .padding(.bottom, 50)
            
            Group {
                HStack {
                    Text("닉네임: ")
                        .frame(width: 80, alignment: .leading)
                    TextField("닉네임", text: $nickName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .onAppear() {
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                }
                
                HStack {
                    Text("성별: ")
                        .frame(width: 80, alignment: .leading)
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
                
                HStack {
                    Text("키: ")
                        .frame(width: 80, alignment: .leading)
                    TextField("키", text: $height)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: height) { heightValue in
                            if !heightValue.allSatisfy({ $0.isNumber || $0 == "." }) {
                                showAlert = true
                                alertMessage = "숫자만 입력하세요!"
                                height = heightValue.filter { $0.isNumber || $0 == "." }
                            }
                        }
                }
                
                HStack {
                    Text("몸무게: ")
                        .frame(width: 80, alignment: .leading)
                    TextField("몸무게", text: $weight)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: weight) { weightValue in
                            if !weightValue.allSatisfy({ $0.isNumber || $0 == "." }) {
                                showAlert = true
                                alertMessage = "숫자만 입력하세요!"
                                weight = weightValue.filter { $0.isNumber || $0 == "." }
                            }
                        }
                }
                
                HStack {
                    Text("나이: ")
                        .frame(width: 80, alignment: .leading)
                    TextField("나이", text: $age)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: age) { ageValue in
                            if !ageValue.allSatisfy({ $0.isNumber || $0 == " " }) {
                                showAlert = true
                                alertMessage = "숫자만 입력하세요!"
                                age = ageValue.filter { $0.isNumber || $0 == " " }
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
        .padding()
        // showAlert가 true일 때 출력
        .alert(isPresented: $showAlert) {
            Alert(title: Text("잘못된 입력"), message: Text(alertMessage),
                  dismissButton: .default(Text("확인"))
            )
        }
    }
}

#Preview {
    UserInfo()
}
