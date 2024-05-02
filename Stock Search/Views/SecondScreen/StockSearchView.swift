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
                    ScrollView(){
                        DetailsView(viewModel:viewModel).padding(.bottom, 0)
                        TabView() {
                            VStack(spacing: 0){
                                HourlyChartView(viewModel: viewModel).frame(height: 400).padding(0)
                                Divider().padding(0).padding(.bottom, 6)
                            }.padding(0).tabItem {
                                Label("Hourly", systemImage: "chart.xyaxis.line")
                                
                            }
                            VStack(spacing: 0){
                                HistoricalChartView(viewModel: viewModel).frame(height: 400).padding(0)
                                Divider().padding(0).padding(.bottom, 6)
                            }.padding(0).tabItem {
                                Label("Historical", systemImage: "clock")
                            }
                            


                        }.padding(0).frame(height: 435)
                        
                        StockPortfolioView(viewModel: viewModel, pf:pf).padding(.top, 15)
                        StatsView(viewModel: viewModel).padding(.top, 10)
                        AboutView(viewModel: viewModel, pf: pf, wl: wl)
                        InsightsView(viewModel: viewModel)
                        ScrollView(.vertical){
                            RecommendationView(viewModel: viewModel).frame(height: 390).padding(0)
                        }.frame(height: 380).scrollIndicators(.hidden).padding(.top, 35)
                        
                        ScrollView(.vertical){
                            SurpriseView(viewModel: viewModel).frame(height: 390).padding(0)
                        }.frame(height: 380).scrollIndicators(.hidden).padding(.top, 35)
                        
                        NewsView(viewModel: viewModel)
                    }.padding(0).navigationBarTitle(ticker)
                }
            }.navigationBarItems(trailing: Button(action: {
                if !isWatchlisted {
                    wl.addStock(stock: viewModel.details, quote: viewModel.quote)
                    showToast = true
                    ToastMessage = "Adding \(viewModel.symbol) to Favorites"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showToast = false
                        ToastMessage = ""
                    }
                    
                } else {
                    wl.deleteStock(stock: viewModel.symbol)
                    showToast = true
                    ToastMessage = "Removing \(viewModel.symbol) to Favorites"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showToast = false
                        ToastMessage = ""
                    }
                }
                isWatchlisted.toggle()
            }) {
                Image(systemName: isWatchlisted ? "plus.circle.fill" : "plus.circle")}).onAppear(){
                    isWatchlisted = wl.watchlist.stocks.contains { $0.ticker == viewModel.symbol }
                }.toast(isShowing: $showToast, text: ToastMessage).safeAreaInset(edge: .bottom) {
                    HStack{}.padding(.bottom, 10)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                }
    }
}



#Preview {
    StockSearchView(ticker: "NVDA", viewModel: StockSearchViewModel(symbol: "AAPL"), pf: PortfolioViewModel(), wl: WatchlistViewModel())
}
