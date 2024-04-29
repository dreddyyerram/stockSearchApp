//
//  StatsView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/20/24.
//

import SwiftUI

struct StatsView: View {
    @StateObject var viewModel: StockSearchViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
                    Text("Stats")
                        .font(.title3)
                        .padding(.vertical)
            HStack{
                VStack{
                    HStack {
                        Text("High Price:  ").font(.footnote).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("$\(viewModel.quote.h, specifier: "%.2f")").font(.footnote)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Text("Low Price: ").font(.footnote).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("$\(viewModel.quote.h, specifier: "%.2f")").font(.footnote)
                        Spacer()
                    }
                    
                   
                }
                VStack{
                    HStack {
                        Text("Open Price: ").font(.footnote).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("$\(viewModel.quote.o, specifier: "%.2f")").font(.footnote)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Text("Prev. Close: ").font(.footnote).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("$\(viewModel.quote.o, specifier: "%.2f")").font(.footnote)
                        Spacer()
                    }
                }
            }
                    
        }.padding(.horizontal)
    }
}

#Preview {
    StatsView(viewModel: StockSearchViewModel(symbol: "AAPL"))
}
