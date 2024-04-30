//
//  StockPortfolioView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/19/24.
//

import SwiftUI

struct StockPortfolioView: View {
    @StateObject var viewModel: StockSearchViewModel
    @StateObject var pf : PortfolioViewModel
    @State private var doTrade = false
    @State var stock: PortfolioStock?
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text("Portfolio").font(.title2).fontWeight(.regular)
            HStack{
                if let stock = pf.getStock(symbol: viewModel.symbol){
                    VStack(spacing:12){
                        HStack {
                            Text("Shares Owned:").fontWeight(.semibold).font(.footnote)
                            Text("\(stock.quantity)").font(.footnote)
                            Spacer()
                        }
                        HStack {
                            Text("Avg. Cost / Share:").fontWeight(.semibold).font(.footnote)
    
                            Text("$\(stock.avg_price, specifier: "%.2f")").font(.footnote)
                            Spacer()
                        }
                        HStack {
                            Text("Total Cost:").fontWeight(.semibold).font(.footnote)
                            Text("$\(stock.total_price, specifier: "%.2f")").font(.footnote)
                            Spacer()
                        }
                        HStack {
                            Text("Change:").fontWeight(.semibold).font(.footnote)
                            Text("$\(stock.change, specifier: "%.2f")")
                                .foregroundColor(stock.change >= 0 ? .green : .red).font(.footnote)
                            Spacer()
                        }
                        HStack {
                            Text("Market Value:").fontWeight(.semibold).font(.footnote)
                            Text("$\(stock.mrkt_value, specifier: "%.2f")")
                                .foregroundColor(stock.change >= 0 ? .green : .red).font(.footnote)
                            Spacer()
                        }
        
                    }
                }
                else{
                    VStack(alignment: .leading){
                        Text("You have 0 shares of \(viewModel.symbol).").font(.caption)
                        Text("Start trading!")}.font(.caption)
                }
                
                
                
                HStack{
                    Spacer()
                    Button(action: {
                        viewModel.updateQuote()
                        doTrade.toggle()
                        
                    }) {
                        Text("Trade").padding().font(.subheadline).fontWeight(.bold)
                        
                    }
                    .padding(.horizontal, 40)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(40).sheet(isPresented: $doTrade) {
                        PurchaseView(isPresented: $doTrade, viewModel: viewModel, pf: pf)
                        }

                }
        }
        }.padding(.horizontal)
        .background(Color.white)
        .cornerRadius(12).onAppear(){
            self.stock = pf.getStock(symbol: viewModel.symbol)
        }
    
    }
}

#Preview {
    StockPortfolioView(viewModel: StockSearchViewModel(symbol: "AAPL"), pf: PortfolioViewModel())
}
