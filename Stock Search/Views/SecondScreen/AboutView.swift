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
            VStack(alignment: .leading, spacing: 8) {
                Text("About").font(.title3).fontWeight(.medium)
                Spacer()
                HStack{
                    VStack(alignment: .leading){
                        Text("IPO Start Date:").fontWeight(.medium).font(.caption)
                        Spacer()
                        Text("Industry:").fontWeight(.medium).font(.caption)
                        Spacer()
                        Text("Webpage:").fontWeight(.medium).font(.caption)
                        Spacer()
                        Text("Company Peers:").fontWeight(.medium).font(.caption)
                        Spacer()
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    VStack(alignment: .leading){
                        Text("\(viewModel.details.ipo)").font(.caption)
                        Spacer()
                        Text("\(viewModel.details.finnhubIndustry)").font(.caption)
                        Spacer()
                        
                        Link("\(viewModel.details.weburl)", destination: URL(string: "\(viewModel.details.weburl)")!).font(.caption)
                        Spacer()
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(viewModel.peers, id: \.self){ peer in
                                    NavigationLink(destination: StockSearchView(ticker: peer, viewModel: StockSearchViewModel(symbol: peer), pf: pf, wl: wl)) {
                                        Text("\(peer),")
                                            .foregroundColor(.blue).font(.caption)
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
    
    }
}

#Preview {
    AboutView(viewModel: StockSearchViewModel(symbol: "AAPL"),  pf: PortfolioViewModel(), wl: WatchlistViewModel())
}
