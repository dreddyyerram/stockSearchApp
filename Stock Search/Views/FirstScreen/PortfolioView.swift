//
//  PortfolioView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/16/24.
//

import SwiftUI


struct PortfolioView: View {
    @StateObject var pf: PortfolioViewModel
    @StateObject var wl: WatchlistViewModel
    var body: some View {
        
        Section(header: Text("Portfolio")) {
            HStack{
                VStack(alignment: .leading){
                    Text("Net Worth")
                    Text("$\(String(format: "%.2f", pf.portfolio.networth))")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                VStack(alignment: .leading){
                    
                    Text("Cash Balance")
                    Text("$\(String(format: "%.2f", pf.portfolio.balance))")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            }
            
            ForEach(pf.portfolio.stocks, id: \.self) { stock in
                PortfolioRow(portfolio: stock, pf: pf, wl: wl).alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                    return viewDimensions[.listRowSeparatorLeading] + 170

                }
            }.onMove(perform: { indices, newOffset in
                pf.move(fromOffsets: indices, toOffset: newOffset)
            })
            
    
            
        }
    }
}

struct PortfolioRow: View {
    let portfolio: PortfolioStock
    @StateObject var pf: PortfolioViewModel
    @StateObject var wl: WatchlistViewModel
    var body: some View {
        NavigationLink(destination: StockSearchView(ticker: portfolio.ticker, viewModel: StockSearchViewModel(symbol: portfolio.ticker), pf: pf, wl: wl)){
            HStack{
                VStack(alignment: .leading) {
                    Text(portfolio.ticker)
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(portfolio.quantity) shares")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(String(format: "%.2f", portfolio.mrkt_value))
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    if portfolio.change > 0{
                        HStack{
                            Image(systemName: "arrow.up.right")
                            Text("$\(String(format: "%.2f", portfolio.change * Double(portfolio.quantity))) (\(String(format: "%.2f", portfolio.percent))%)")
                                .font(.subheadline)
                                
                        }.foregroundColor(.green)
                    }
                    else if portfolio.change < 0{
                        HStack{
                            Image(systemName: "arrow.down.right")
                            Text("$\(String(format: "%.2f", portfolio.change * Double(portfolio.quantity))) (\(String(format: "%.2f", portfolio.percent))%)")
                                .font(.subheadline)
                            
                        }.foregroundColor(.red)
                    }
                    else  {
                        HStack{
                            Image(systemName: "minus")
                            Text("$\(String(format: "%.2f", portfolio.change * Double(portfolio.quantity))) (\(String(format: "%.2f", portfolio.percent))%)")
                                .font(.subheadline)
                                
                        }.foregroundColor(.secondary)
                    }
                   
                }
            }
        }
    

    }
}



#Preview {
    PortfolioView(pf: PortfolioViewModel(), wl: WatchlistViewModel())
}
