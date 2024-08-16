//
//  InputFoodCalorie.swift
//  BibleProject
//
//  Created by 곽현우 on 8/10/24.
//

import SwiftUI

struct InputFoodCalorie : View {
    @State private var food : String = ""
    @State private var calorie : String = ""
    @State private var addButton : Bool = false
//    @Binding var nowCalorie : Int
    
    var body: some View{
        VStack{
            
            Group{
                HStack{
                    Spacer()
                    Text("음식: ")
                        .frame(width: 80, alignment: .leading)
                    TextField("음식", text: $food)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .onAppear(){
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                    Spacer()
                }
                HStack{
                    Spacer()
                    Text("칼로리: ")
                        .frame(width: 80, alignment: .leading)
                    TextField("칼로리", text: $calorie)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .onAppear(){
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                    Spacer()
                }
                
                Button(action: {
                    self.addButton = true
                }){
                    Text("추가")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    InputFoodCalorie()
}
