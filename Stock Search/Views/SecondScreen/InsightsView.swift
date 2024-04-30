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
        VStack(alignment: .leading, spacing: 10) {
            HStack{Text("Insights").font(.title2).fontWeight(.regular)}.padding(.bottom,0)
            HStack{
                Spacer()
                Text("Insider Sentiments").font(.title2).fontWeight(.regular)
                Spacer()
            }.padding(.bottom, 10)
            HStack(spacing:25){
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.details.name).fontWeight(.bold).font(.subheadline)
                    Divider()
                    Text("Total").fontWeight(.bold).font(.subheadline)
                    Divider()
                    Text("Positive").fontWeight(.bold).font(.subheadline)
                    Divider()
                    Text("Negative").fontWeight(.bold).font(.subheadline)
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("MSPR").fontWeight(.bold).font(.subheadline)
                    Divider()
                    Text("\(viewModel.insights.msprPositive + viewModel.insights.msprNegative, specifier: "%.2f")").font(.subheadline).fontWeight(.regular)
                    Divider()
                    Text("\(viewModel.insights.msprPositive, specifier: "%.2f")").font(.subheadline).fontWeight(.regular)
                    Divider()
                    Text("\(viewModel.insights.msprNegative, specifier: "%.2f")").font(.subheadline).fontWeight(.regular)
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Change").fontWeight(.bold).font(.subheadline)
                    Divider()
                    Text("\(viewModel.insights.changePositive + viewModel.insights.changeNegative, specifier: "%.2f")").font(.subheadline).fontWeight(.regular)
                    Divider()
                    Text("\(viewModel.insights.changePositive, specifier: "%.2f")").font(.subheadline).fontWeight(.regular)
                    Divider()
                    Text("\(viewModel.insights.changeNegative, specifier: "%.2f")").font(.subheadline).fontWeight(.regular)
                    Divider()
                }.padding(.trailing,0)
            }
        }.padding(.leading)
    }
}

#Preview {
    InsightsView(viewModel: StockSearchViewModel(symbol: "AAPL"))
}
