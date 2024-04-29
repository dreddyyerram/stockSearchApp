//
//  InsightsView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/20/24.
//

import SwiftUI

struct InsightsView: View {
    @StateObject var viewModel: StockSearchViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack{Text("Insights").font(.title3).fontWeight(.medium).padding(0)}.padding(0)
            HStack{
                Spacer()
                Text("Insider Sentiments").font(.title3)
                Spacer()
            }.padding()
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Apple Inc").fontWeight(.medium).font(.subheadline)
                    Divider()
                    Text("Total").fontWeight(.medium).font(.subheadline)
                    Divider()
                    Text("Positive").fontWeight(.medium).font(.subheadline)
                    Divider()
                    Text("Negative").fontWeight(.medium).font(.subheadline)
                    Divider()
                }
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text("MSPR").fontWeight(.medium).font(.subheadline)
                    Divider()
                    Text("\(viewModel.insights.msprPositive + viewModel.insights.msprNegative, specifier: "%.2f")").font(.subheadline)
                    Divider()
                    Text("\(viewModel.insights.msprPositive, specifier: "%.2f")").font(.subheadline)
                    Divider()
                    Text("\(viewModel.insights.msprNegative, specifier: "%.2f")").font(.subheadline)
                    Divider()
                }
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Change").fontWeight(.medium).font(.subheadline)
                    Divider()
                    Text("\(viewModel.insights.changePositive + viewModel.insights.changeNegative, specifier: "%.2f")").font(.subheadline)
                    Divider()
                    Text("\(viewModel.insights.changePositive, specifier: "%.2f")").font(.subheadline)
                    Divider()
                    Text("\(viewModel.insights.changeNegative, specifier: "%.2f")").font(.subheadline)
                    Divider()
                }
            }
        }.padding(.horizontal)
    }
}

#Preview {
    InsightsView(viewModel: StockSearchViewModel(symbol: "AAPL"))
}
