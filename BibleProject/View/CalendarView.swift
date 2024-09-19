//
//  CalendarView.swift
//  BibleProject
//
//  Created by 곽현우 on 8/14/24.
//

import SwiftUI
import SwiftData

struct CalendarView : View{
    
    @State private var date = Date()
    var body: some View{
        VStack(alignment: .leading) {
            Image("TitleImage1")
                .resizable()
                .frame(maxWidth: 130, maxHeight: 50)
//                .background(.yellow)
                .padding()
                
            VStack(alignment:.center){
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
            }
        }
        Spacer()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.blue)
    }
}

extension CalendarView {
    
}

#Preview {
    CalendarView()
}
