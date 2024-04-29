//
//  PurchaseView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/23/24.
//

import SwiftUI

struct PurchaseView: View {
    @Binding var isPresented: Bool
    @StateObject var viewModel: StockSearchViewModel
    @StateObject var pf : PortfolioViewModel
    @State var numberOfShares: String = ""
    @State var showToast: Bool = false
    @State var ToastMessage: String = ""
    @State var SuccessFlag: Bool = false
    @State var SuccessMessage: String = ""

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.secondary).fontWeight(.bold)
                }
                .padding()
                .accessibilityLabel(Text("Close"))
            }
            Text("Trade \(viewModel.details.name) shares").fontWeight(.bold)
            Spacer()
            
            VStack(spacing: 15) {
                

                Spacer()
                HStack(alignment: .bottom){
                    VStack{
                        TextField("0", text: $numberOfShares)
                            .keyboardType(.numberPad)
                            .textFieldStyle(PlainTextFieldStyle()).padding(0).font(.system(size: 100, weight: .light))
                            .onChange(of: numberOfShares) { oldValue, newValue in
                                showToast = false
                            }
                    }.onTapGesture(perform: {
                        showToast = false
                    })
                    Spacer()
                    VStack{
                        Text("\(Int(numberOfShares) ?? 0 <= 1 ? "Share" : "Shares")")
                            .font(.largeTitle).padding(.bottom, 25)
                    }
                    
    
                }.padding(.bottom, 0)
                HStack{
                    Spacer()
                    Text("x $\(viewModel.quote.c, specifier: "%.2f")/share = $\((Double(numberOfShares) ?? 0) * viewModel.quote.c, specifier: "%.2f")").padding(.top, 0)
                    
                }.padding(.top, 0)
                    Spacer()

                Text("$\(pf.portfolio.balance, specifier: "%.2f") available to buy \(viewModel.symbol)").foregroundStyle(.secondary).font(.footnote)
                VStack{

                    HStack(spacing: 13) {
                        Button("Buy") {
                            self.buy()
                        }
                        .buttonStyle(PrimaryButtonStyle()).font(.footnote)
                        
                        Button("Sell") {
                            self.sell()
                            
                        }
                        .buttonStyle(PrimaryButtonStyle()).font(.footnote)
                        
                    }.padding(0)
                }
                }
                            
                         
                        
                        Spacer()
            
        }.padding().toast(isShowing: $showToast, text: ToastMessage).sheet(isPresented: $SuccessFlag) {
            SuccessView(isPresented: self.$SuccessFlag, parentPresented: self.$isPresented, message: self.SuccessMessage)
        }
    }
    
    
    func sell(){
        let stockIndex = pf.portfolio.stocks.firstIndex(where: {$0.ticker == viewModel.symbol}) ?? -1
        let shares = Int(numberOfShares) ?? 0
        if shares == 0{
            showToast = true
            ToastMessage = "Please enter a valid amount"
        }
        else if shares < 0 {
            showToast = true
            ToastMessage = "Cannot buy non-positive shares"
        }
        else if shares > pf.portfolio.stocks[stockIndex].quantity {
            showToast = true
            ToastMessage = "Not enough shares to sell"
        }
        else{
            
            self.SuccessFlag = true
            self.SuccessMessage = "You have successfully sold \(numberOfShares) shares of \(viewModel.symbol))"
            pf.sellStock(stock: viewModel.details, quote: viewModel.quote, quantity: shares)
            
        }
        
    }
    
    
    func buy(){
        let shares = Int(numberOfShares) ?? 0
        if shares == 0{
            showToast = true
            ToastMessage = "Please enter a valid amount"
        }
        else if shares < 0{
            showToast = true
            ToastMessage = "Cannot sell non-positive shares"
        }
        else if Double(shares) * viewModel.quote.c > pf.portfolio.balance {
            showToast = true
            ToastMessage = "Not enough money to buy"
        }
        else{
            self.SuccessFlag = true
            self.SuccessMessage = "You have successfully bought \(numberOfShares) shares of \(viewModel.symbol)"
            pf.buyStock(stock: viewModel.details, quote: viewModel.quote, quantity: shares)
        }
    }
}



struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Capsule())

    }
}

extension String {
    var isNumber: Bool {
        let characters = CharacterSet.decimalDigits

        return CharacterSet(charactersIn: self).isSubset(of: characters)
    }
}

#Preview {
    PurchaseView(isPresented: .constant(true), viewModel: StockSearchViewModel(symbol: "AAPL"), pf: PortfolioViewModel())
}
