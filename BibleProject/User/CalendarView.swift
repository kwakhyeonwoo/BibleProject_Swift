//
//  CalendarView.swift
//  BibleProject
//
//  Created by 곽현우 on 8/14/24.
//

import SwiftUI

struct CalendarView : View {
    var body: some View{
        DatePicker(selection: .constant(Date()), label: { Text("Date") })
    }
}

#Preview {
    CalendarView()
}
