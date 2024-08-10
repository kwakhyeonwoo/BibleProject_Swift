//
//  FirstPageView.swift
//  BibleProject
//
//  Created by 곽현우 on 8/10/24.
//

import SwiftUI


struct FirstPageView: View {
    @State private var navigateToNextPage = false

    var body: some View {
        VStack {
            if navigateToNextPage {
                SecondPageView()
            } else {
                VStack {
                    
                    Image(systemName: "app.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.top, 5)

                    // 앱 이름 텍스트
                    Text("Stop Eat")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                }
                .transition(.opacity)
                .onAppear {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            navigateToNextPage = true
                        }
                    }
                }
            }
        }
    }
}
