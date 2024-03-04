//
//  CheckBoxStyle.swift
//  Devote
//
//  Created by Maya Ghamloush on 04/03/2024.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack{
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }//HStack
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Toggle("PLaceHolder label", isOn: .constant(true))
        .toggleStyle(CheckBoxStyle())
        .padding()
        .previewLayout(.sizeThatFits)
    
}
