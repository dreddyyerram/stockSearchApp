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
                    Text("Net Worth").font(.title2)
                    Text("$\(String(format: "%.2f", pf.portfolio.networth))")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.title2)
                }
                Spacer()
                VStack(alignment: .leading){
                    
                    Text("Cash Balance").font(.title2)
                    Text("$\(String(format: "%.2f", pf.portfolio.balance))")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.title2)
                }
            }
            
            ForEach(pf.portfolio.stocks, id: \.self) { stock in
                PortfolioRow(portfolio: stock, pf: pf, wl: wl).alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                    return viewDimensions[.listRowSeparatorLeading] + 190

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
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(portfolio.quantity) shares")
                        .font(.headline).fontWeight(.regular)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(String(format: "$%.2f", portfolio.mrkt_value))
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    if portfolio.change > 0{
                        HStack{
                            Image(systemName: "arrow.up.right").font(.title3).padding(.trailing, 5)
                            Text("$\(String(format: "%.2f", portfolio.change * Double(portfolio.quantity))) (\(String(format: "%.2f", portfolio.percent))%)")
                                .font(.headline)
                                
                        }.foregroundColor(.green)
                    }
                    else if portfolio.change < 0{
                        HStack{
                            Image(systemName: "arrow.down.right").font(.title3).padding(.trailing, 5)
                            Text("$\(String(format: "%.2f", portfolio.change * Double(portfolio.quantity))) (\(String(format: "%.2f", portfolio.percent))%)")
                                .font(.headline)
                            
                        }.foregroundColor(.red)
                    }
                    else  {
                        HStack{
                            Image(systemName: "minus").font(.title3).padding(.trailing, 5)
                            Text("$\(String(format: "%.2f", portfolio.change * Double(portfolio.quantity))) (\(String(format: "%.2f", portfolio.percent))%)")
                                .font(.headline)
                                
                        }.foregroundColor(.gray)
                    }
                   
                }
            }
        }
    

    }
}



#Preview {
    PortfolioView(pf: PortfolioViewModel(), wl: WatchlistViewModel())
}
