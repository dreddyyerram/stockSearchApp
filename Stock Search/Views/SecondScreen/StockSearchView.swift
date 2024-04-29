//
//  StockSearchView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/19/24.
//

import SwiftUI


struct StockSearchView: View {
    @State private var selectedTab: Int = 0
    var ticker: String
    @StateObject var viewModel: StockSearchViewModel
    @StateObject var pf: PortfolioViewModel
    @StateObject var wl: WatchlistViewModel
    @State private var isWatchlisted = false
    @State var showToast: Bool = false
    @State var ToastMessage: String = ""

    var body: some View {
            VStack{
                if viewModel.isLoading {
                        ProgressView("Fetching Data...")
                } else {
                    ScrollView{
                        DetailsView(viewModel:viewModel)
                        TabView(selection: $selectedTab) {
                            
                            HourlyChartView(viewModel: viewModel).tag(0)
                                .tabItem {
                                    Label("Hourly", systemImage: "chart.xyaxis.line")
                                }
                            
                            HistoricalChartView(viewModel: viewModel).tag(1)
                                .tabItem {
                                    Label("Historical", systemImage: "clock")
                                }

                        }.frame(height: 500).padding(.top, 0).padding(0)
                        StockPortfolioView(viewModel: viewModel, pf:pf).padding(.top, 20)
                        StatsView(viewModel: viewModel)
                        AboutView(viewModel: viewModel, pf: pf, wl:wl)
                        InsightsView(viewModel: viewModel)
                        ScrollView(.vertical){
                            RecommendationView(viewModel: viewModel).frame(height: 450).padding(0)
                        }.frame(height: 445).scrollIndicators(.hidden)
                        
                        ScrollView(.vertical){
                            SurpriseView(viewModel: viewModel).frame(height: 450).padding(0)
                        }.frame(height: 445).scrollIndicators(.hidden)
                        
                        NewsView(viewModel: viewModel)
                    }.padding(0)
                }
            }.navigationBarTitle(ticker).navigationBarItems(trailing: Button(action: {
                if !isWatchlisted {
                    wl.addStock(stock: viewModel.details, quote: viewModel.quote)
                    showToast = true
                    ToastMessage = "Added \(viewModel.symbol) to Favorites"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showToast = false
                        ToastMessage = ""
                    }
                    
                } else {
                    wl.deleteStock(stock: viewModel.symbol)
                    showToast = true
                    ToastMessage = "Removed \(viewModel.symbol) to Favorites"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showToast = false
                        ToastMessage = ""
                    }
                }
                isWatchlisted.toggle()
            }) {
                Image(systemName: isWatchlisted ? "plus.circle.fill" : "plus.circle")}).onAppear(){
                    isWatchlisted = wl.watchlist.stocks.contains { $0.ticker == viewModel.symbol }
                }.toast(isShowing: $showToast, text: ToastMessage)
    }
}


#Preview {
    StockSearchView(ticker: "NVDA", viewModel: StockSearchViewModel(symbol: "NVDA"), pf: PortfolioViewModel(), wl: WatchlistViewModel())
}
