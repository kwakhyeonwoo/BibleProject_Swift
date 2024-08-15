//
//  UserInfo.swift
//  BibleProject
//
//  Created by 곽현우 on 8/5/24.
//

import SwiftUI
import Foundation

struct UserInfo: View {
    
    @ObservedObject var requireUser: StateUserModel
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var selectedColor: Color = .white
    
    @State private var navigateToMainUserView = false
    let circleSize: CGFloat = 30
    
    let colors: [Color] = [.black, .blue, .red, .yellow]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                // 원 이미지와 원형 버튼들
                ZStack(alignment: .center) {
                    Image("Paris5")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        // 선택된 색상에 따라 이미지 색 변경
                        .colorMultiply(selectedColor)
                        .overlay(
                            GeometryReader { geometry in
                                let centerX = geometry.size.width / 2
                                let centerY = geometry.size.height / 2
                                // 이미지 주위에 버튼 배치할 반지름 설정
                                let radius = geometry.size.width / 2 + circleSize
                                
                                ForEach(0..<colors.count, id: \.self) { colorIndex in
                                    let angle = Angle(degrees: Double(colorIndex) / Double(colors.count) * -180)
                                    let xOffset = cos(angle.radians) * radius
                                    let yOffset = sin(angle.radians) * radius
                                    Button(action: {
                                        // 버튼 클릭 시 배경색 변경
                                        selectedColor = colors[colorIndex]
                                    }) {
                                        Circle()
                                            .frame(width: circleSize, height: circleSize)
                                            .foregroundColor(colors[colorIndex])
                                    }
                                    .position(x: centerX + xOffset, y: centerY + yOffset)
                                }
                                
                                // ColorPicker가 곡선 안에 위치하도록 오프셋 설정
                                let colorPickerOffset = radius + 10
                                let angle = Angle(degrees: Double(colors.count) / Double(colors.count) * -180)
                                let xOffset = cos(angle.radians) * colorPickerOffset
                                let yOffset = sin(angle.radians) * colorPickerOffset
                                
                                VStack {
                                    ColorPicker("색상 선택", selection: $selectedColor)
                                        .labelsHidden()
                                }
                                // ColorPicker 배치
                                .position(x: centerX + xOffset, y: centerY + yOffset)
                                
                            }
                        )
                        .frame(width: 300, height: 300)
                }
                .padding(.bottom, -50)
                
                Group {
                    HStack {
                        Text("닉네임: ")
                            .frame(width: 80, alignment: .leading)
                        TextField("닉네임", text: $requireUser.nickName)
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
                            self.requireUser.gender = true
                        }, label: {
                            Text("남성")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(self.requireUser.gender == true ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        })
                        
                        Button(action: {
                            self.requireUser.gender = false
                        }, label: {
                            Text("여성")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(self.requireUser.gender == false ? Color.pink : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        })
                    }
                    
                    HStack {
                        Text("키: ")
                            .frame(width: 80, alignment: .leading)
                        TextField("키", text: $requireUser.height)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: requireUser.height) { heightValue in
                                if !heightValue.allSatisfy({ $0.isNumber || $0 == "." }) {
                                    showAlert = true
                                    alertMessage = "숫자만 입력하세요!"
                                    requireUser.height = heightValue.filter { $0.isNumber || $0 == "." }
                                }
                            }
                    }
                    
                    HStack {
                        Text("몸무게: ")
                            .frame(width: 80, alignment: .leading)
                        TextField("몸무게", text: $requireUser.weight)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: requireUser.weight) { weightValue in
                                if !weightValue.allSatisfy({ $0.isNumber || $0 == "." }) {
                                    showAlert = true
                                    alertMessage = "숫자만 입력하세요!"
                                    requireUser.weight = weightValue.filter { $0.isNumber || $0 == "." }
                                }
                            }
                    }
                    
                    HStack {
                        Text("나이: ")
                            .frame(width: 80, alignment: .leading)
                        TextField("나이", text: $requireUser.age)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: requireUser.age) { ageValue in
                                if !ageValue.allSatisfy({ $0.isNumber || $0 == " " }) {
                                    showAlert = true
                                    alertMessage = "숫자만 입력하세요!"
                                    requireUser.age = ageValue.filter { $0.isNumber || $0 == " " }
                                }
                            }
                    }
                    
                    NavigationLink(
                        destination: MainUserView(user: requireUser),
                        isActive: $navigateToMainUserView
                    ) {
                        Text("생성")
                            .frame(width: 50, height: 30)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        navigateToMainUserView = true
                    })
                }
                .padding(.horizontal)
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("잘못된 입력"), message: Text(alertMessage),
                      dismissButton: .default(Text("확인")))
            }
        }
    }
}

#Preview {
    UserInfo(requireUser: StateUserModel())
}
