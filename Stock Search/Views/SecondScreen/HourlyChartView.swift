//
//  HourlyChartView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/19/24.
//

import SwiftUI

struct HourlyChartView: View {
    @StateObject var viewModel: StockSearchViewModel
    var body: some View {
        if(!viewModel.isLoading){
            WebView(response: ChartJSData(stock: viewModel.symbol, chartType: "hourly", chartResponse: viewModel.hourlyChart, quote: viewModel.quote))
        }
    }
}

#Preview {
    HourlyChartView(viewModel: StockSearchViewModel(symbol: "AAPL"))
}
