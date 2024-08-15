//
//  CalendarView.swift
//  BibleProject
//
//  Created by 곽현우 on 8/14/24.
//

import SwiftUI

struct CalendarView : View{
    
    @State private var date = Date()
    var body: some View{
        DatePicker(
            "Start Date",
            selection: $date,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
    }
}

#Preview {
    CalendarView()
}
