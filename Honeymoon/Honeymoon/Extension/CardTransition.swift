//
//  CardTransition.swift
//  Honeymoon
//
//  Created by user219285 on 4/5/23.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(insertion: .identity,
                                 removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge: .bottom)))
    }
    
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(insertion: .identity,
                                 removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom)))
    }
}
