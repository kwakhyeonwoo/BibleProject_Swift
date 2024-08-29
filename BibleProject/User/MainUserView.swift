//
//  MainUserView.swift
//  BibleProject
//
//  Created by 곽현우 on 8/10/24.
//

import SwiftUI

//커스텀 UIKit만들어서 SwiftUI에 적용하기
struct KeyBoardDismissViewMainUserView : UIViewRepresentable{
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
struct MainUserView: View {
    @ObservedObject var user: StateUserModel
    @ObservedObject var basicColor: ImageBasicColor
    
    @State private var todayCalorie: String = ""
    @State private var delCalorie: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var userMessage = ""
    @State private var nowCalorie: Int = 0
    @State private var selectedTab: Int? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                VStack(alignment: .center, spacing: 16) {
                    
                    // 오늘의 칼로리 입력
                    let calorieGoal = Double(todayCalorie) ?? 1
                    // 현재 칼로리
                    let calorieIntake = Double(nowCalorie)
                    let caloriePercentage = (calorieIntake / calorieGoal) * 100
                    
                    // MARK: 이미지 클릭 시 칼로리 기입
                    NavigationLink(destination: InputFoodCalorie(nowCalorie: $nowCalorie)) {
                        if caloriePercentage < 0 {
                            Image("Image4")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .colorMultiply(basicColor.selectedColor)
                                .onAppear {
                                    basicColor.selectedImage = "Image4"
                                }
                        } else if caloriePercentage == 0 {
                            Image("Image0")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .colorMultiply(basicColor.selectedColor)
                                .onAppear {
                                    basicColor.selectedImage = "Image0"
                                }
                        } else if caloriePercentage <= 70 {
                            Image("Image1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .colorMultiply(basicColor.selectedColor)
                                .onAppear {
                                    basicColor.selectedImage = "Image1"
                                }
                        } else if caloriePercentage <= 100 {
                            Image("Image2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .colorMultiply(basicColor.selectedColor)
                                .onAppear {
                                    basicColor.selectedImage = "Image2"
                                }
                        } else {
                            Image("Image3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .colorMultiply(basicColor.selectedColor)
                                .onAppear {
                                    basicColor.selectedImage = "Image3"
                                }
                        }
                    }
                    Text("\(user.nickName)님 반갑습니다")
                    
                    // MARK: 오늘의 칼로리
                    VStack(spacing: 16) {
                        HStack {
                            Text("오늘의 칼로리:")
                                .frame(width: 100, alignment: .leading) // 고정 너비 설정
                            TextField("오늘의 칼로리 입력", text: $todayCalorie)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal)
                        
                        // HStack for delCalorie omitted
                    }
                    
                    // MARK: 현재 칼로리 보여주기
                    HStack {
                        Text("현재 칼로리: ")
                        Text("\(nowCalorie)")
                    }
                    
                    // MARK: 권장 칼로리 Alert
                    Button(action: {
                        SuggestCal()
                    }) {
                        Text("나의 권장 칼로리 확인하기")
                    }
                    
                    // MARK: 나의 정보 Alert
                    Button(action: {
                        showAlert = true
                        userMessage = "\(user.nickName)님의 정보는\n\n" +
                                      "닉네임: \(user.nickName)\n" +
                                      "성별: \(user.gender == true ? "남성" : "여성")\n" +
                                      "키: \(user.height) cm\n" +
                                      "몸무게: \(user.weight) kg\n" +
                                      "나이: \(user.age)세"
                        alertMessage = userMessage
                    }) {
                        Text("내 정보 확인하기")
                    }
                    
                }
                .padding()
                
                Spacer()
                
                // MARK: TabView - 캘린더
                HStack(spacing: 100) {
                    NavigationLink(destination: CalendarView(), tag: 1, selection: $selectedTab) {
                        Button(action: {
                            selectedTab = 1
                        }) {
                            VStack {
                                Image(systemName: "calendar")
                                    .font(.system(size: 30))
                            }
                        }
                    }
                    
                    // MARK: TabView - 홈 화면
                    NavigationLink(destination: UserInfo(requireUser: StateUserModel(), basicColor: ImageBasicColor()), tag: 2, selection: $selectedTab) {
                        Button(action: {
                            selectedTab = 2
                        }) {
                            VStack {
                                Image(systemName: "house")
                                    .font(.system(size: 30))
                            }
                        }
                    }
                    
                    // MARK: TabView - 유저 정보
                    NavigationLink(destination: UserSetting(userRequire: user, basicColor: basicColor), tag: 3, selection: $selectedTab) {
                        Button(action: {
                            selectedTab = 3
                        }) {
                            VStack {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 30))
                            }
                        }
                    }
                }
                .font(.headline)
                // TabView가 사라지지 않도록 추가적인 공간 확보
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("\(user.nickName)님의 정보"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("확인"))
                )
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .background(KeyBoardDismissViewMainUserView().edgesIgnoringSafeArea(.all))
        }
    }
    
    // MARK: - 권장 칼로리
    func SuggestCal() {
        let heightValue = Double(user.height) ?? 0
        let weightValue = Double(user.weight) ?? 0
        let ageValue = Double(user.age) ?? 0
        var recommendedCalories: String
        
        if user.gender == true {
            // 남자 권장 칼로리
            let manBaseCal = 10 * weightValue + 6.25 * heightValue - 5 * ageValue + 5
            recommendedCalories = String(format: "%.0f", manBaseCal * 1.55)
        } else if user.gender == false {
            // 여자 권장 칼로리
            let womanBaseCal = 10 * weightValue + 6.25 * heightValue - 5 * ageValue - 161
            recommendedCalories = String(format: "%.0f", womanBaseCal * 1.55)
        } else {
            recommendedCalories = "성별이 설정되지 않았습니다."
        }
        
        alertMessage = "권장 칼로리는 \(recommendedCalories) 입니다."
        showAlert = true
    }
}



//외부 공간 클릭시 키보드 내려감
extension View{
    func hideKeyboardMainUserView(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    MainUserView(user: StateUserModel(), basicColor: ImageBasicColor())
}
