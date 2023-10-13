//
//  AmmenitiesRow.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 13/10/2023.
//

import SwiftUI

//this is a view that will be used to have numbers next to a symbol
//for example, numbers of bed will also contain a bed symbol.
struct AmmenitiesRow: View {
    @State var total: Int
    @State var systemImageStr: String
    @State var accessibilityLabel: String
    var body: some View {
        HStack(spacing: 10) {
            Text("\(total)")
            Image(systemName: systemImageStr)
        }.accessibilityLabel(Text("\(total) \(accessibilityLabel)"))
    }
}

#Preview {
    AmmenitiesRow(total: 3, systemImageStr: "bed.double.fill", accessibilityLabel: "Rooms")
}
