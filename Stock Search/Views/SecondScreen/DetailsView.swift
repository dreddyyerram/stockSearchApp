//
//  DetailsView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/19/24.
//

import SwiftUI
import Kingfisher

struct DetailsView: View {
    @StateObject var viewModel: StockSearchViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack{
                Text(viewModel.details.name).font(.subheadline).foregroundColor(.secondary)
                Spacer()
                KFImage.url(URL(string: viewModel.details.logo)).resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40).cornerRadius(10)
            }.padding(.horizontal)
            HStack{
                Text("$\(String(format: "%.2f", viewModel.quote.c))").font(.largeTitle).fontWeight(.medium).padding(0)
                HStack{
                    Image(systemName: viewModel.quote.d >= 0 ? "arrow.up.right" : "arrow.down.right")
                    Text("$\(viewModel.quote.d, specifier: "%.2f") (\(String(format: "%.2f", viewModel.quote.dp))%)")
                        .font(.title3)
                    
                }.foregroundColor(viewModel.quote.d >= 0 ? .green : .red ).padding(.horizontal, 5)
            }.padding(.horizontal)
            
        }.padding(.bottom, 0)
    }
}

#Preview {
    DetailsView(viewModel: StockSearchViewModel(symbol: "AAPL"))
}
