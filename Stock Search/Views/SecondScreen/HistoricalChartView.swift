//
//  HistoricalChartView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/19/24.
//

import SwiftUI

struct HistoricalChartView: View {
    @StateObject var viewModel: StockSearchViewModel
    var body: some View {
        if(!viewModel.isLoading){
            WebView(response: ChartJSData(stock: viewModel.symbol, chartType: "stock", chartResponse: viewModel.Chart))
        }
    }
}

#Preview {
    HistoricalChartView(viewModel: StockSearchViewModel(symbol: "AAPL"))
}
