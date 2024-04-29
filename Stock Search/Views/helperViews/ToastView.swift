//
//  ToastView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/27/24.
//

import SwiftUI

struct ToastView<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    let presenting: () -> Presenting
    let text: String

    var body: some View {

        GeometryReader { geometry in
            

            ZStack(alignment: .center) {

                self.presenting()
                
                VStack(){
                    Spacer()
                    HStack(){
                        Spacer()
                        VStack(){
                            Text(text).foregroundColor(Color.white)
                        }
                        .frame(width: geometry.size.width / 1.3,
                               height: geometry.size.height / 12)
                        .background(.gray)
                        .clipShape(Capsule())
                        .transition(.slide)
                        .opacity(self.isShowing ? 1 : 0).padding(.bottom, 18)
                        Spacer()
                        
                    }
                    
                }
                

            }

        }

    }

}

extension View {
    func toast(isShowing: Binding<Bool>, text: String) -> some View {
        ToastView(isShowing: isShowing,
              presenting: { self },
              text: text)
    }
}



#Preview {
    ToastView(isShowing: .constant(true), presenting: { VStack{
        Spacer()
        Text("haha")
        Spacer()} }, text: "Not enough to sell")
}
