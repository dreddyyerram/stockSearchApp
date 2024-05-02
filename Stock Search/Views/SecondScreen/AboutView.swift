//
//  AboutView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/20/24.
//

import SwiftUI

struct AboutView: View {
    @StateObject var viewModel: StockSearchViewModel
    @StateObject var pf: PortfolioViewModel
    @StateObject var wl: WatchlistViewModel

    var body: some View {
        if(!viewModel.isLoading){
            VStack(alignment: .leading, spacing: 13) {
                Text("About").font(.title2).fontWeight(.regular)
                HStack{
                    VStack(alignment: .leading, spacing: 6){
                        Text("IPO Start Date:").fontWeight(.medium).font(.footnote)
                        Text("Industry:").fontWeight(.medium).font(.footnote)
                        Text("Webpage:").fontWeight(.medium).font(.footnote)
                        Text("Company Peers:").fontWeight(.medium).font(.footnote)
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    VStack(alignment: .leading, spacing: 6){
                        Text("\(viewModel.details.ipo)").font(.footnote)
                        
                        Text("\(viewModel.details.finnhubIndustry)").font(.footnote)
                        
                        
                        Link("\(viewModel.details.weburl)", destination: URL(string: "\(viewModel.details.weburl)")!).font(.footnote)
                        
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(viewModel.peers, id: \.self){ peer in
                                    NavigationLink(destination: StockSearchView(ticker: peer, viewModel: StockSearchViewModel(symbol: peer), pf: pf, wl: WatchlistViewModel(fetch: true))) {
                                        Text("\(peer),")
                                            .foregroundColor(.blue).font(.footnote)
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
        }
    
    }
}

#Preview {
    AboutView(viewModel: StockSearchViewModel(symbol: "AAPL"),  pf: PortfolioViewModel(), wl: WatchlistViewModel())
}
