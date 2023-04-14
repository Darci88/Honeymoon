//
//  TitleModifier.swift
//  Honeymoon
//
//  Created by user219285 on 4/5/23.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.pink)
    }
}

