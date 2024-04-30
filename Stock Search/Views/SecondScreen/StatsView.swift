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
        VStack(alignment: .leading, spacing: 12) {
                    Text("Stats")
                .font(.title2).fontWeight(.regular)
            HStack{
                VStack(spacing: 12){
                    HStack {
                        Text("High Price:  ").font(.footnote).fontWeight(.semibold)
                        Text("$\(viewModel.quote.h, specifier: "%.2f")").font(.footnote)
                        Spacer()
                    }
                    HStack {
                        Text("Low Price: ").font(.footnote).fontWeight(.semibold)
                        Text("$\(viewModel.quote.l, specifier: "%.2f")").font(.footnote)
                        Spacer()
                    }
                    
                   
                }
                VStack(spacing: 12){
                    HStack {
                        Text("Open Price: ").font(.footnote).fontWeight(.semibold)
                        Text("$\(viewModel.quote.o, specifier: "%.2f")").font(.footnote)
                        Spacer()
                    }
                    HStack {
                        Text("Prev. Close: ").font(.footnote).fontWeight(.semibold)
                        Text("$\(viewModel.quote.pc, specifier: "%.2f")").font(.footnote)
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
