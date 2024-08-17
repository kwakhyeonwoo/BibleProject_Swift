//
//  MainUserView.swift
//  BibleProject
//
//  Created by 곽현우 on 8/10/24.
//

import SwiftUI

//커스텀 UIKit만들어서 SwiftUI에 적용하기
struct KeyBoardDismissView : UIViewRepresentable{
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
    @State private var todayCalorie: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var nowCalorie : Int = 0
    
    @State private var selectedTab: Int? = nil
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack(spacing: 110) {
                    Spacer()

                    VStack(alignment: .center, spacing: 16) {
                        NavigationLink(destination: InputFoodCalorie(nowCalorie: $nowCalorie)){
                            Image("Paris5")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.yellow)
                                
                                
                        }
                        
                        Text("\(user.nickName)님 반갑습니다")
                        
                        HStack {
                            Text("오늘의 칼로리: ")
                            TextField("오늘의 칼로리 입력", text: $todayCalorie)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: todayCalorie) { calorie in
                                    if !calorie.allSatisfy({ $0.isNumber || $0 == "." }) {
                                        showAlert = true
                                        alertMessage = "숫자만 입력해주세요"
                                        todayCalorie = calorie.filter { $0.isNumber || $0 == "." }
                                    }
                                }
                        }
                        
                        HStack{
                            Text("현재 칼로리: ")
                            Text("\(nowCalorie)")
                        }
                        
                        Button(action: {
                            SuggestCal()
                        }) {
                            Text("나의 권장 칼로리 확인하기")
                        }
                        .padding()
                    }
                    .padding()

                    Spacer()

                    HStack(spacing: 100){
                        NavigationLink(destination: CalendarView(), tag: 1, selection: $selectedTab){
                            Button(action: {
                                selectedTab = 1
                            }){
                                VStack{
                                    Image(systemName: "calendar")
                                        .font(.system(size: 30))
                                }
                            }
                        }
                        
                        NavigationLink(destination: UserInfo(requireUser: StateUserModel()), tag: 2, selection: $selectedTab){
                            Button(action: {
                                selectedTab = 2
                            }){
                                VStack{
                                    Image(systemName: "house")
                                        .font(.system(size: 30))
                                }
                            }
                        }
                        
                        NavigationLink(destination: UserSetting(), tag: 3, selection: $selectedTab){
                            Button(action: {
                                selectedTab = 3
                            }){
                                VStack{
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 30))
                                }
                            }
                        }
                    }
                    .font(.headline)
                    .padding(.bottom, 100)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("\(user.nickName)의 권장 칼로리는"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
                }
            }//ZStack
            
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
            //ZStack모든 공간에 클릭시 키보드 숨김
            KeyBoardDismissView()
                .edgesIgnoringSafeArea(.all)
        }
    }

    func SuggestCal() {
        let heightValue = Double(user.height) ?? 0
        var recommendedCalories: String
        
        if user.gender == true {
            //남자 권장 칼로리
            recommendedCalories = String(format: "%.0f", (heightValue - 100) * 0.9 * 33)
        } else if user.gender == false {
            //여자 권장 칼로리
            recommendedCalories = String(format: "%.0f", (heightValue - 110) * 0.9 * 33)
        } else {
            recommendedCalories = "성별이 설정되지 않았습니다."
        }
        
        alertMessage = "권장 칼로리는 \(recommendedCalories)입니다."
        showAlert = true
    }
}

//외부 공간 클릭시 키보드 내려감
extension View{
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    MainUserView(user: StateUserModel())
}
