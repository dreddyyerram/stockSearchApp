//
//  AutoCompleteView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/18/24.
//

import SwiftUI

struct AutoCompleteView: View {
    @StateObject var AVC : AutoCompleteViewModel
    @Binding var symbol: String
    @StateObject var pf: PortfolioViewModel
    @StateObject var wl: WatchlistViewModel
    
    
    var body: some View {
        Section{
            ForEach(AVC.searchResults, id: \.self) { result in
                NavigationLink(destination: StockSearchView(ticker: result.symbol, viewModel: StockSearchViewModel(symbol: result.symbol), pf: pf, wl: wl)) {
                    VStack(alignment: .leading) {
                        Text(result.symbol).fontWeight(.bold).font(.title3)
                        Text(result.description).foregroundColor(.secondary)
                    }
                }
            }
        }}
}


#Preview {
    AutoCompleteView(AVC: AutoCompleteViewModel(), symbol: .constant("AAPL"), pf: PortfolioViewModel(), wl: WatchlistViewModel())
}

