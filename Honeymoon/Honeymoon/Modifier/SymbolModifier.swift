//
//  SymbolModifier.swift
//  Honeymoon
//
//  Created by user219285 on 4/5/23.
//

import SwiftUI

struct SymbolModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 128))
            .shadow(color: .black.opacity(0.3), radius: 12, x: 0, y: 0)
    }
}
