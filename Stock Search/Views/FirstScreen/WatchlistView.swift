//
//  WatchlistView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/17/24.
//

import SwiftUI

struct WatchlistView: View {
    @StateObject var pf: PortfolioViewModel
    @StateObject var wl: WatchlistViewModel
    var body: some View {
            Section(header: Text("Favorites")) {
                ForEach(wl.watchlist.stocks, id: \.self) { stock in
                    WatchlistRow(stock: stock, pf: pf, wl: wl).alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                        return viewDimensions[.listRowSeparatorLeading] + 190}
                }.onMove(perform: { indices, newOffset in
                    wl.move(fromOffsets: indices, toOffset: newOffset)
                }).onDelete(perform: { indexSet in 
                    wl.delete(atOffsets: indexSet)
                })
            }
    }
}


struct WatchlistRow: View {
    let stock: WatchlistStock
    @StateObject var pf: PortfolioViewModel
    @StateObject var wl: WatchlistViewModel
    var body: some View {
        NavigationLink(destination: StockSearchView(ticker:stock.ticker, viewModel: StockSearchViewModel(symbol: stock.ticker), pf: pf, wl: wl)){
            HStack{
                    VStack(alignment: .leading) {
                        Text(stock.ticker)
                            .font(.title3)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text(stock.name)
                            .font(.headline)
                            .foregroundColor(.gray).fontWeight(.regular)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(String(format: "$%.2f", stock.quote.c))
                            .font(.headline)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                        if stock.quote.d > 0{
                            HStack{
                                Image(systemName: "arrow.up.right").font(.title3).padding(.trailing, 5)
                                Text("$\(String(format: "%.2f", stock.quote.d)) (\(String(format: "%.2f", stock.quote.dp))%)")
                                    .font(.headline)
                                
                            }.foregroundColor(.green)
                        }
                        else if stock.quote.d < 0{
                            HStack{
                                Image(systemName: "arrow.down.right").font(.title3).padding(.trailing, 5)
                                Text("$\(String(format: "%.2f", stock.quote.d)) (\(String(format: "%.2f", stock.quote.dp))%)")
                                    .font(.headline)
                                
                            }.foregroundColor(.red )
                        }
                        else  {
                            HStack{
                                Image(systemName:"minus").font(.title3).padding(.trailing, 5)
                                Text("$\(String(format: "%.2f", stock.quote.d)) (\(String(format: "%.2f", stock.quote.dp))%)")
                                    .font(.headline)
                                
                            }.foregroundColor(.gray)
                        }
                        
                    }
                }
        }

    }
}


#Preview {
    WatchlistView(pf: PortfolioViewModel(), wl: WatchlistViewModel())
}
