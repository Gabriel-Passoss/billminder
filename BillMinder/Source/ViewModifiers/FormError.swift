//
//  CustomTextField.swift
//  BillMinder
//
//  Created by Gabriel on 09/04/25.
//

import SwiftUI

struct FormError: ViewModifier {
    let errorMessage: String?
    
    func body(content: Content) -> some View {
            VStack(alignment: .leading, spacing: 4) {
                content
                
                if let error = errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }

}

#Preview {
    TextField("Test", text: .constant(""))
        .modifier(FormError(errorMessage: "Error"))
}
