//
//  StateUser.swift
//  BibleProject
//
//  Created by 곽현우 on 8/10/24.
//

import SwiftUI

class StateUserModel : ObservableObject {
    @Published var nickName : String = ""
    @Published var gender : Bool? = nil
    @Published var height : String = ""
    @Published var weight : String = ""
    @Published var age : String = ""
}
