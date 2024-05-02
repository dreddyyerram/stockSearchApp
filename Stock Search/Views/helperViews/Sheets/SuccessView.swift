//
//  SuccessView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/27/24.
//

import SwiftUI

struct SuccessView: View {
    @Binding var isPresented: Bool
    @Binding var parentPresented: Bool
    @State var message: String
    var body: some View {
        VStack(spacing: 20) {
                    Spacer()
                    
                    Text("Congratulations!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(message)
                        .fontWeight(.semibold)
                        .foregroundColor(.white).font(.subheadline)
                        .multilineTextAlignment(.center).padding(.horizontal, 25)
                    
                    Spacer()
                    
                    Button("Done") {
                        parentPresented = false
                       
                    }.frame(width: 300)
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
                    .background(Color.white)
                    .clipShape(Capsule())
            
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.green)

    }
}

#Preview {
    SuccessView(isPresented: .constant(true), parentPresented: .constant(true), message: "you have successfully sold 11 shares of NVDA")
}
