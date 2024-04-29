//
//  SurpriseView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/20/24.
//

import SwiftUI

struct SurpriseView: View {
    @StateObject var viewModel: StockSearchViewModel
    var body: some View {
        if(!viewModel.isLoading){
            WebView(response: ChartJSData(stock: viewModel.symbol, chartType: "earning", earnings: viewModel.earnings)).padding(0)
            
        }
    }
}

#Preview {
    SurpriseView(viewModel: StockSearchViewModel(symbol: "AAPL"))
}
