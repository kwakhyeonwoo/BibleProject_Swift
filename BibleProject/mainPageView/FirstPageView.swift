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
                    
                    Image("newImage1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding(.top, 5)

                    // 앱 이름 텍스트
                    Image("TitleImage1")
                        .resizable()
                        .frame(maxWidth: 130, maxHeight: 50)
                        .padding()
                        
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

