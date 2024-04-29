//
//  ContentView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/13/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symbol = ""
    @StateObject var AVC = AutoCompleteViewModel()
    @StateObject var pf = PortfolioViewModel()
    @StateObject var wl = WatchlistViewModel()
    
    var body: some View {
        NavigationView {
            
            List{
                if !symbol.isEmpty {
                    AutoCompleteView(AVC: AVC, symbol: $symbol, pf:pf, wl:wl)
                }
                else{
                    Section{
                        HStack{
                            Text(Date().formatted(.dateTime.month(.wide).day().year()))
                                .font(.title)
                                .foregroundColor(.secondary)
                                .fontWeight(.bold).padding(4)
                        }
                    }
                    
                    PortfolioView(pf: pf, wl: wl).onAppear(perform: {
                        pf.updateQuotesForPortfolio()
                    })
                    
                    
                    WatchlistView(pf: pf, wl: wl).onAppear(perform: {
                        wl.updateQuotesForWatchlist()
                    })
                    
                    Section{
                        HStack {
                            Spacer()
                            Link("Powered by Finnhub.io", destination: URL(string: "https://www.finnhub.io")!)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                    }
                }
                
            }.toolbar{
                EditButton()
            }.navigationTitle("Stocks").searchable(text: $symbol, placement: .navigationBarDrawer(displayMode: .always))
            
            
        }.onChange(of: symbol) {
            oldState, newState in
            AVC.search(query: newState)
        }
            
    
        
        
    }
}

#Preview {
    ContentView()
}
