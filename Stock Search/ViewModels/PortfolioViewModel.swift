//
//  PortfolioViewModel.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/16/24.
//

import Foundation
import Alamofire
import SwiftyJSON

final class PortfolioViewModel: ObservableObject{
    
    @Published var portfolio: Portfolio = mockPortfolio
    @Published var isLoading = false;
    @Published var errorMessage: String?
    var network = Network()
    
    
    init(){
        self.fetchPortfolio()
    }
    
    
    func move(fromOffsets: IndexSet, toOffset: Int){
        portfolio.stocks.move(fromOffsets: fromOffsets, toOffset: toOffset)
        self.syncPortfolio()
    }
    
        
    
    func updateStockData(index: Int, quote: Quote){
        portfolio.stocks[index].current_price = quote.c
        portfolio.stocks[index].avg_price = portfolio.stocks[index].total_price / Double(portfolio.stocks[index].quantity)
        portfolio.stocks[index].change = quote.c - portfolio.stocks[index].avg_price
        portfolio.stocks[index].mrkt_value = quote.c * Double(portfolio.stocks[index].quantity)
        portfolio.stocks[index].percent = (portfolio.stocks[index].change / portfolio.stocks[index].avg_price) * 100
    }
    
    
    func updateStockData(symbol: String, quote: Quote){
        let index = getStockIndex(symbol: symbol) ?? -1
        if index == -1 {
            return
        }
        portfolio.stocks[index].current_price = quote.c
        portfolio.stocks[index].avg_price = portfolio.stocks[index].total_price / Double(portfolio.stocks[index].quantity)
        portfolio.stocks[index].change = quote.c - portfolio.stocks[index].avg_price
        portfolio.stocks[index].mrkt_value = quote.c * Double(portfolio.stocks[index].quantity)
        portfolio.stocks[index].percent = (portfolio.stocks[index].change / portfolio.stocks[index].avg_price) * 100
    }
    
    func syncPortfolio(){
        let url = Constants.baseUrl.appending("/mongoDb/HW3/Portfolio?user=User")
        AF.request(url, method: .put, parameters: portfolio, encoder: JSONParameterEncoder.default).response { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(_):
                    print(response.response as Any)
                    print("Portfolio synced successfully")
                case .failure(let error):
                    self.errorMessage = "Failed to sync portfolio: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func buyStock(stock: StockDetails, quote: Quote, quantity: Int){
        var index = getStockIndex(symbol: stock.ticker) ?? -1
        if index == -1 {
            let stock = PortfolioStock(ticker: stock.ticker, name: stock.ticker, quantity: 0, total_price: 0, current_price: 0, avg_price: 0, change: 0, mrkt_value: 0, percent: 0)
            self.portfolio.stocks.append(stock)
        }
        index = getStockIndex(symbol: stock.ticker)  ?? -1
        let purchaseAmount = quote.c * Double(quantity)
        portfolio.stocks[index].quantity += quantity
        portfolio.stocks[index].total_price += purchaseAmount
        updateStockData(index: index, quote: quote)
        portfolio.balance -= purchaseAmount
        print(self.portfolio)
        self.syncPortfolio()
    }
    
    func sellStock(stock: StockDetails, quote: Quote, quantity: Int){
        let index = getStockIndex(symbol: stock.ticker) ?? -1
        let purchaseAmount = quote.c * Double(quantity)
        portfolio.stocks[index].quantity -= quantity
        portfolio.stocks[index].total_price -= purchaseAmount
        updateStockData(index: index, quote: quote)
        portfolio.balance += purchaseAmount
        if portfolio.stocks[index].quantity == 0 {
            portfolio.stocks.remove(at: index)
        }
        print(self.portfolio)
        self.syncPortfolio()
    }
    
    func updateQuotesForPortfolio() {
        let dispatchGroup = DispatchGroup()

        for index in portfolio.stocks.indices {
            dispatchGroup.enter()
            network.fetchQuotes(ticker: portfolio.stocks[index].ticker) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case .success(let quote):
                        self.updateStockData(index: index, quote: quote)
                    case .failure(let error):
                        print("Failed to fetch quote for \(self.portfolio.stocks[index].ticker): \(error)")
                    }
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
            self.calculateNetworth()
            print("All quotes updated")
        }
    }
    
    func calculateNetworth(){
        var networth = 0.0
        for stock in portfolio.stocks {
            networth += stock.mrkt_value
        }
        networth += portfolio.balance
        portfolio.networth = networth
    }
    
    func getStockIndex(symbol: String) -> Int?{
        return self.portfolio.stocks.firstIndex(where: {$0.ticker == symbol})
    }
    
    func getStock(symbol: String) -> PortfolioStock?{
        let stock = self.portfolio.stocks.first(where: {$0.ticker == symbol})
        return stock
        
    }
    
    
    
    
    func fetchPortfolio() {
        self.isLoading = true
        errorMessage = nil
        
        let url = Constants.baseUrl.appending("/mongoDb/HW3/Portfolio?user=User")
        
        AF.request(url).responseDecodable(of: Portfolio.self) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response.result {
                case .success(let portfolioData):
                    self.portfolio = portfolioData
                    self.updateQuotesForPortfolio()
                case .failure(let error):
                    self.errorMessage = "Failed to fetch portfolio: \(error.localizedDescription)"
                }
            }
        }
    }
    
}

    

