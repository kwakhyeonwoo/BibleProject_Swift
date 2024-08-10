//
//  MainUserView.swift
//  BibleProject
//
//  Created by 곽현우 on 8/10/24.
//

import SwiftUI

struct MainUserView: View {
    @ObservedObject var user: StateUserModel
    
    var body: some View {
        Text("닉네임: \(user.nickName), 성별: \(user.gender == true ? "남성" : "여성"), 키: \(user.height), 몸무게: \(user.weight), 나이: \(user.age)")
            .navigationTitle("Main User View")
    }
}

#Preview {
    MainUserView(user: StateUserModel())
}
