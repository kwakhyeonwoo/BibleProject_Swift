//
//  UserInfo.swift
//  BibleProject
//
//  Created by 곽현우 on 8/5/24.
//

import SwiftUI
import Foundation

struct KeyBoardDismissViewUserInfo : UIViewRepresentable{
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator{
        @objc func dismissKeyboard(){
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct UserInfo: View {

    @ObservedObject var requireUser: StateUserModel
    @ObservedObject var basicColor: ImageBasicColor

    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var selectedColor: Color = .white
    @State private var navigateToMainUserView = false
    let circleSize: CGFloat = 30
    let colors: [Color] = [.purple, .blue, .red, .yellow]

    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){
                Image("TitleImage1")
                    .resizable()
                    .frame(maxWidth: 130, maxHeight: 50)
                    .padding()
//                    .background(.yellow)
//                    .padding(.bottom, 40)
                VStack(alignment: .center) {
                    ZStack(alignment: .center) {
                        Image("newImage1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .colorMultiply(basicColor.selectedColor)
                            .overlay(
                                GeometryReader { geometry in
                                    let centerX = geometry.size.width / 2
                                    let centerY = geometry.size.height / 2
                                    let radius = geometry.size.width / 2 + circleSize

                                    ForEach(0..<colors.count, id: \.self) { colorIndex in
                                        let angle = Angle(degrees: Double(colorIndex) / Double(colors.count) * -180)
                                        let xOffset = cos(angle.radians) * radius
                                        let yOffset = sin(angle.radians) * radius
                                        Button(action: {
                                            basicColor.selectedColor = colors[colorIndex]
                                        }) {
                                            Circle()
                                                .frame(width: circleSize, height: circleSize)
                                                .foregroundColor(colors[colorIndex])
                                        }
                                        .position(x: centerX + xOffset, y: centerY + yOffset)
                                    }

                                    let colorPickerOffset = radius + 10
                                    let angle = Angle(degrees: Double(colors.count) / Double(colors.count) * -180)
                                    let xOffset = cos(angle.radians) * colorPickerOffset
                                    let yOffset = sin(angle.radians) * colorPickerOffset

                                    VStack {
                                        ColorPicker("색상 선택", selection: $basicColor.selectedColor)
                                            .labelsHidden()
                                    }
                                    .position(x: centerX + xOffset, y: centerY + yOffset)
                                }
                            )
                            .frame(width: 300, height: 300)
                    }
                    .padding(.bottom, -50)
                    .offset(y: 20)

                    
                    HStack {
                        VStack(spacing: 20){
                            TextField("닉네임", text: $requireUser.nickName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .onAppear {
                                    UITextField.appearance().clearButtonMode = .whileEditing
                                }
                            
                            HStack {
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
                            
                            TextField("키", text: $requireUser.height)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            TextField("몸무게", text: $requireUser.weight)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            TextField("나이", text: $requireUser.age)
                                .submitLabel(.done)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.bottom, 30)
                    .padding(30)

                     
                    // MARK: 생성 버튼
                    Button(action: {
                        if requireUser.nickName.isEmpty || requireUser.height.isEmpty || requireUser.weight.isEmpty || requireUser.age.isEmpty {
                            showAlert = true
                            alertMessage = "모든 필드를 입력해주세요!"
                        } else {
                            // 네비게이션을 실행하려면 `navigateToMainUserView`를 `true`로 설정
                            navigateToMainUserView = true
                        }
                    }) {
                        Text("생성")
                            .frame(width: 50, height: 30)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 40)
                    
                    // 네비게이션 링크를 숨기고 버튼 클릭 시 네비게이션을 수행
                    NavigationLink(
                        destination: MainUserView(user: requireUser, basicColor: basicColor),
                        isActive: $navigateToMainUserView
                    ) {
                        EmptyView()
                    }
                }
                .padding(.bottom, 30)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("잘못된 입력"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("확인"))
                    )
                }
            .background(KeyBoardDismissViewUserInfo().edgesIgnoringSafeArea(.all))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func hideKeyboardUserInfo(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    UserInfo(requireUser: StateUserModel(), basicColor: ImageBasicColor())
}
