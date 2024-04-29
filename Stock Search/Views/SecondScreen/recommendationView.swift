//
//  recommendationView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/20/24.
//

import SwiftUI

struct RecommendationView: View {
    @StateObject var viewModel: StockSearchViewModel
    var body: some View {
        if(!viewModel.isLoading){
            WebView(response: ChartJSData(stock: viewModel.symbol, chartType: "recommendation", recommends: viewModel.recommendation)).padding(0)
            
        }
    }
}

#Preview {
    RecommendationView(viewModel: StockSearchViewModel(symbol: "AAPL"))
}
