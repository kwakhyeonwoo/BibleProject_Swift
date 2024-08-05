//
//  UserInfo.swift
//  BibleProject
//
//  Created by 곽현우 on 8/5/24.
//

//import SwiftUI
//import Foundation
//
////유저 정보 한 곳에 보관
//enum Userinfo : Hashable{
//    case nickName, gender, heigth, weight, age
//}
//
////enum의 값이 변함에 따라 실시간으로 View 변경
//class UserinfoViewModel : ObservableObject{
//    @Published var nickName : String = ""
//    @Published var gender : Int = 0
//    @Published var height : Int = Int()
//    @Published var weight : Int = Int()
//    @Published var age : Int = Int()
//    
//}
//
//struct UserinfoView : View {
//    @FocusState private var formUser : Userinfo?
//    @AccessibilityFocusState private var formVoUser : Userinfo?
//    //viewModel에 UserinfoViewModel생성
//    @ObservedObject private var viewModel :UserinfoViewModel = UserinfoViewModel()
//    
//    
//    var body: some View{
//        Grid{
//            GridRow{
//                Text("닉네임: ").dynamicTypeSize(.large)
//                TextField("닉네임", text: $viewModel.nickName, onCommit: {
//                    
//                })
//                
//                    
//            }
//            
//            //성별, 0이면 남자, 1이면 여자
//            GridRow{
//                Text("성별: ")
//                HStack{
//                    Button(action: {viewModel.gender = 0}, label: {Text("남자").dynamicTypeSize(.large)})
//                        .accessibilityLabel("남자")
//                        .accessibilityAddTraits(viewModel.gender == 0 ? .isSelected : [])
//                    Button(action: {viewModel.gender = 1},label: {Text("여자").dynamicTypeSize(.large)})
//                        .accessibilityLabel("여자")
//                        .accessibilityAddTraits(viewModel.gender == 1 ? .isSelected : [])
//                        .accessibilityRemoveTraits(viewModel.gender != 1 ? .isSelected : [])
//                    Spacer()
//                }
//            }
//        }
//    }
//}


import SwiftUI
import Foundation

struct UserInfo : View {
    
    @State var nickName : String = ""
    @State var gender : Bool = true
    @State var height : CGFloat = 0
    @State var weight : CGFloat = 0
    @State var age : CGFloat = 0
    
    var body: some View{
        
        VStack{
            HStack(alignment: .center){
                Text("닉네임: ")
                    .padding()
                TextField("닉네임", text: $nickName)
                    .padding()
                    .onAppear(){
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
//                    .background(Color.yellow)
            }
            HStack{
                Text("성별: ")
                    .padding()
                Button("남자") {
                    self.gender = gender
                }
                
                .background(gender ? Color.blue : Color.pink)
                .foregroundColor(.white)
//                .frame(width: 100)
                Button("여자") {
                    self.gender = gender
                }
                .background(self.gender ? Color.blue : Color.pink)
                .foregroundColor(.white)
            }
            HStack{
                Text("키: ")
                    .padding()
                TextField("키", value: $height, formatter: NumberFormatter())
                
            }
            HStack{
                Text("몸무게: ")
                    .padding()
                TextField("몸무게", value: $weight, formatter: NumberFormatter())
//                    .background(Color.yellow)
            }
            HStack{
                Text("나이: ")
                    .padding()
                TextField("나이", value: $age, formatter: NumberFormatter())
            }
        }
    }
}

#Preview {
    UserInfo()
}
