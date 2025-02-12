//
//  PaletteView.swift
//  HM
//
//  Created by Vitalii Kuznetsov on 2025-02-11.
//

import SwiftUI

/// View displaying horizontal stack of colored rectangles.
struct PaletteView: View {
    
    @State
    var limit: Int
    
    @State
    var colors: [UIColor]
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(Array(self.colors.enumerated()), id: \.offset) { index, element in
                if index < self.limit {
                    Rectangle()
                        .fill(Color(uiColor: element))
                        .frame(width: 10, height: 10)
                        .border(Color.black, width: 1)
                }
            }
            if self.colors.count > self.limit {
                Text("+\(self.colors.count - self.limit)")
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    PaletteView(limit: 3, colors: [
        .red,
        .green,
        .blue,
        .purple,
        .gray
    ])
}
