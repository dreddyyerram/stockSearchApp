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
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Portfolio").font(.title3).fontWeight(.medium)
            HStack{
                if let index = pf.getStockIndex(symbol: viewModel.symbol){
                    VStack{
                        HStack {
                            Text("Shares Owned:").fontWeight(.medium).font(.caption)
                            Text("\(pf.portfolio.stocks[index].quantity)").font(.caption)
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Text("Avg. Cost / Share:").fontWeight(.medium).font(.caption)
    
                            Text("$\(pf.portfolio.stocks[index].avg_price, specifier: "%.2f")").font(.caption)
                            Spacer()
                        }
                        Spacer()
                        
                        HStack {
                            Text("Total Cost:").fontWeight(.medium).font(.caption)
                            Text("$\(pf.portfolio.stocks[index].total_price, specifier: "%.2f")").font(.caption)
                            Spacer()
                        }
                        Spacer()
                        
                        HStack {
                            Text("Change:").fontWeight(.medium).font(.caption)
                            Text("\(pf.portfolio.stocks[index].change, specifier: "%.2f")")
                                .foregroundColor(pf.portfolio.stocks[index].change >= 0 ? .green : .red).font(.caption)
                            Spacer()
                        }
                        Spacer()
                        
                        HStack {
                            Text("Market Value:").fontWeight(.medium).font(.caption)
                            Text("$\(pf.portfolio.stocks[index].mrkt_value, specifier: "%.2f")")
                                .foregroundColor(pf.portfolio.stocks[index].change >= 0 ? .green : .red).font(.caption)
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
                        doTrade.toggle()
                        viewModel.updateQuote()
                    }) {
                        Text("Trade").padding().font(.subheadline).fontWeight(.bold)
                        
                    }
                    .padding(.horizontal, 40)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(40).sheet(isPresented: $doTrade) {
                        PurchaseView(isPresented: $doTrade, viewModel: viewModel, pf: pf)
                        }
                    Spacer()
                }
        }
        }.padding(.horizontal)
        .background(Color.white)
        .cornerRadius(12)
    
    }
}

#Preview {
    StockPortfolioView(viewModel: StockSearchViewModel(symbol: "MSFT"), pf: PortfolioViewModel())
}
