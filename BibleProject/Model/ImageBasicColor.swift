//
//  ImageBasicColor.swift
//  BibleProject
//
//  Created by 곽현우 on 8/23/24.
//

import SwiftUI

//UserInfo, MainUserView, UserSetting에서 사용하기 위해 @Published사용
class ImageBasicColor : ObservableObject {
    @Published var selectedColor : Color = .white
    @Published var selectedImage : String = "Image0"
}
