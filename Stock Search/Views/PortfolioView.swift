//
//  PortfolioView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/16/24.
//

import SwiftUI


struct PortfolioView: View {
    @StateObject private var pf = PortfolioViewModel()
//    let portfoliodata:Portfolio
    var body: some View {
        VStack{
            ForEach(pf.portfolio.stocks, id: \.self) { stock in
                Text(stock.ticker)
            }
        }
    }
}

struct PortfolioRow: View {
    let portfolio: PortfolioStock
    var body: some View {
        HStack {
            Text(portfolio.ticker)
            Spacer()
            Text(portfolio.current_price.formatted())
        }
    }
}



#Preview {
    PortfolioView()
}
