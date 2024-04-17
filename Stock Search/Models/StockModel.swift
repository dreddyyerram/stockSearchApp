//
//  StockModel.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/15/24.
//

import Foundation

struct Stock: Identifiable, Codable {
    let id: String
    let balance: String
    let price: Double
    // Add other properties relevant to a stock
}

struct PortfolioStock: Decodable, Hashable {
    var ticker: String
    var name: String
    var quantity: Int
    var total_price: Double
    var current_price: Double
    var avg_price: Double
    var change: Double
    var mrkt_value: Double
}


struct Portfolio: Decodable {
    var stocks: [PortfolioStock]
    var _id: String
    var balance: Double
    var user: String
}

struct SearchResult: Identifiable, Codable {
    let id: String
    let name: String
    // Add other properties relevant to a search result
}

let mockPortfolio = Portfolio(stocks: [
    PortfolioStock(ticker: "AAPL", name: "Apple Inc.", quantity: 10, total_price: 1000, current_price: 120, avg_price: 100, change: 20, mrkt_value: 1200),
    PortfolioStock(ticker: "GOOGL", name: "Alphabet Inc.", quantity: 5, total_price: 2500, current_price: 2000, avg_price: 500, change: -500, mrkt_value: 10000)
], _id: "1", balance: 5000, user: "User")
