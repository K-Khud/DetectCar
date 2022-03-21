//
//  ButtonLabel.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 25.1.2022.
//

import SwiftUI

public struct ButtonLabel: View {
    public init(title: String, color: Color) {
        self.title = title
        self.color = color
    }

    public var title: String
    public var color: Color

    public var body: some View {
        Text(title)
            .padding()
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(8)
    }
}

public struct ButtonLabel_Previews: PreviewProvider {
    public static var previews: some View {
        ButtonLabel(title: "Title", color: Colors.coral)
    }
}
