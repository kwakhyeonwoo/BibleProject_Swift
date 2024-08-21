//
//  UserSetting.swift
//  BibleProject
//
//  Created by 곽현우 on 8/15/24.
//

import SwiftUI

struct UserSetting : View {
    @ObservedObject var userRequire : StateUserModel
    
    @State private var newWeight : String = ""
    @State private var newHeight : String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center){
                HStack(alignment: .center){
                    
                    Image("Paris5")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    
                    Spacer()
                    
                    Text("\(userRequire.nickName)님 어서오세요")
                    Spacer()
                    
                }//HStack
                Spacer()
                
            }//VStack
            VStack(spacing: 0){
                
                HStack{
                    Text("키: ")
                        .frame(width: 80, alignment: .leading)
                    TextField("바뀐 키", text: $newHeight)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }//HStack
                .frame(maxWidth: .infinity)
                .padding()
                
                HStack{
                    Text("몸무게: ")
                        .frame(width: 80, alignment: .leading)
                    TextField("바뀐 몸무게", text: $newWeight)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }//HStack
                .frame(maxWidth: .infinity)
                .padding()
                
                Button(action: {
                    if !newHeight.isEmpty {
                        userRequire.height = newHeight
                    }
                    
                    if !newWeight.isEmpty{
                        userRequire.weight = newWeight
                    }
                    
                    userRequire.nickName = userRequire.nickName
                    
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("확인")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }//Vstack
            Spacer()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    UserSetting(userRequire: StateUserModel())
}
