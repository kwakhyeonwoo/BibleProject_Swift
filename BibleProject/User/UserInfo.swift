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
    
    // 추가된 상태 변수
    @State private var selectedColor: Color = .white
    let circleSize: CGFloat = 30
    
    // 색상 배열을 사용하여 버튼의 색상 설정
    let colors: [Color] = [.black, .blue, .red, .yellow]
    
    var body: some View {
        VStack(alignment: .center) {
            // 원 이미지와 원형 버튼들
            ZStack(alignment: .center) {
                Image("Paris5")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .colorMultiply(selectedColor) // 선택된 색상에 따라 이미지 색 변경
                    .overlay(
                        GeometryReader { geometry in
                            let centerX = geometry.size.width / 2
                            let centerY = geometry.size.height / 2
                            let radius = geometry.size.width / 2 + circleSize // 이미지 주위에 버튼 배치할 반지름 설정
                            
                            ForEach(0..<colors.count, id: \.self) { colorindex in
                                let angle = Angle(degrees: Double(colorindex) / Double(colors.count) * -180)
                                let xOffset = cos(angle.radians) * radius
                                let yOffset = sin(angle.radians) * radius
                                Button(action: {
                                    selectedColor = colors[colorindex] // 버튼 클릭 시 배경색 변경
                                }) {
                                    Circle()
                                        .frame(width: circleSize, height: circleSize)
                                        .foregroundColor(colors[colorindex])
                                }
                                .position(x: centerX + xOffset, y: centerY + yOffset)
                            }
                            let colorPickerOffset = radius + 10 // ColorPicker가 곡선 안에 위치하도록 오프셋 설정
                            let angle = Angle(degrees: Double(colors.count) / Double(colors.count) * -180)
                            let xOffset = cos(angle.radians) * colorPickerOffset
                            let yOffset = sin(angle.radians) * colorPickerOffset
                            
                            VStack {
                                ColorPicker("색상 선택", selection: $selectedColor)
                                    .labelsHidden()
                            }
                            .position(x: centerX + xOffset, y: centerY + yOffset)
                            // ColorPicker 배치
                        }
                    )
                    .frame(width: 300, height: 300) // ZStack의 크기 설정
            }
            .padding(.bottom, -50)
            
            // 기존 폼 레이아웃
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
