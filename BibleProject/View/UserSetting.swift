//
//  UserSetting.swift
//  BibleProject
//
//  Created by 곽현우 on 8/15/24.
//

import SwiftUI

struct KeyBoardDismissViewUserSetting : UIViewRepresentable{
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
    
    class Coordinator {
        @objc func dismissKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
struct UserSetting : View {
    @ObservedObject var userRequire : StateUserModel
    @ObservedObject var basicColor : ImageBasicColor
    
    @State private var newWeight : String = ""
    @State private var newHeight : String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            NavigationStack{
                
                VStack(alignment: .center, spacing: 10){
                    HStack(alignment: .center){
                        
                        Image(basicColor.selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .colorMultiply(basicColor.selectedColor)
                        
                        Spacer()
                        
                        Text("\(userRequire.nickName)님 어서오세요")
                        Spacer()
                        
                    }//HStack
                    Spacer()
                    
                }//VStack
                .background(KeyBoardDismissViewUserSetting().edgesIgnoringSafeArea(.all))
                
                //userTextField부분
                fixUserinfo
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//                    .background(.yellow)
                //확인 버튼 부분
                buttonClickEvent
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .background(KeyBoardDismissViewUserSetting().edgesIgnoringSafeArea(.all))
            }
        }
    }

#Preview {
    UserSetting(userRequire: StateUserModel(), basicColor: ImageBasicColor())
}

extension UserSetting{
    private var fixUserinfo: some View {
        VStack{
            VStack{
                HStack{
                    Text("닉네임 ")
                        .padding()
                        .frame(width: 80, alignment: .leading)
                    TextField("변경할 닉네임", text: $userRequire.nickName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
                .frame(maxWidth: .infinity)
                .submitLabel(.done)
                
                HStack{
                    Text("키 ")
                        .padding()
                        .frame(width: 80, alignment: .leading)
                    TextField("변경된 키", text: $userRequire.height)
                        .padding(.trailing)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .submitLabel(.done)
                
                HStack{
                    Text("몸무게")
                        .padding()
                        .frame(width: 80, alignment: .leading)
                    TextField("변경된 몸무게", text: $userRequire.weight)
                        .padding(.trailing)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .submitLabel(.done)
                
                HStack{
                    Text("나이")
                        .padding()
                        .frame(width: 80, alignment: .leading)
                    TextField("변경된 나이", text: $userRequire.age)
                        .padding(.trailing)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .submitLabel(.done)
            }
            Spacer()
        }
    }
    
    private var buttonClickEvent : some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("확인")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        
    }
}

extension View {
    func userSettingHideKeyboardMainUserView(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
