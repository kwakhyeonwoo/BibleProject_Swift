//
//  SecondPageView.swift
//  BibleProject
//
//  Created by 곽현우 on 8/10/24.
//

import SwiftUI

struct SecondPageView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var moveUserInfo = false

    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                VStack(spacing: 20) {
                    TextField("ID", text: $id)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)

                HStack(spacing: 20) {
                    // 로그인 버튼
                    NavigationLink(
                        destination: UserInfo(requireUser: StateUserModel()),
                        isActive: $moveUserInfo
                    ) {
                        Button(action: {
                            moveUserInfo = true
                        }) {
                            Text("로그인")
                                .font(.subheadline)
                                .padding(10)
                                .frame(width: 140, height: 40)
                                .background(Color.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .cornerRadius(8)
                        }
                    }
                    
                    // 회원가입 버튼
                    NavigationLink(destination: {
                        // 회원가입 화면 추가
                    }) {
                        Text("회원가입")
                            .font(.subheadline)
                            .padding(10)
                            .frame(width: 140, height: 40)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SecondPageView()
}
