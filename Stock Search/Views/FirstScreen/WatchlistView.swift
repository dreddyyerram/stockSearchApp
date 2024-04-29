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
                    WatchlistRow(stock: stock, pf: pf, wl: wl)
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
                            .font(.headline)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text(stock.name)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(String(format: "%.2f", stock.quote.c))
                            .font(.headline)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        HStack{
                            Image(systemName: stock.quote.d >= 0 ? "arrow.up.right" : "arrow.down.right")
                            Text("$\(stock.quote.d.formatted()) (\(String(format: "%.2f", stock.quote.dp))%)")
                                .font(.subheadline)
                            
                        }.foregroundColor(stock.quote.d >= 0 ? .green : .red )
                    }
                }
        }

    }
}


#Preview {
    WatchlistView(pf: PortfolioViewModel(), wl: WatchlistViewModel())
}
