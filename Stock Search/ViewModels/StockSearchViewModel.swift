//
//  StockSearchViewModel.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/19/24.
//

import Foundation
import Alamofire
import SwiftyJSON

final class StockSearchViewModel: ObservableObject{
    var symbol: String = ""
    var network = Network()
    @Published var isLoading = false;
    @Published var details: StockDetails!
    @Published var quote: Quote!
    @Published var earnings: [Earnings]!
    @Published var news: [News]!
    @Published var peers: Peers!
    @Published var hourlyChart: ChartResponse!
    @Published var Chart: ChartResponse!
    @Published var recommendation: [Recommendation]!
    @Published var insights: Insights!
    @Published var insider: [Insider]!
    @Published var errorMessage: String?
    
    
    
    init(symbol: String){
        self.symbol = symbol
//        self.testData()
        self.fetchData()
    }
    
    func fetchData(){
        
        self.isLoading = true
        let group = DispatchGroup()
        
        group.enter()
        network.fetchDetails(ticker: symbol) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.details = data
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                group.leave()
            }
        }
        
        group.enter()
        network.fetchQuotes(ticker: symbol) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.quote = data
                    let toDate = Date(timeIntervalSince1970: TimeInterval(data.t))
                    let fromDate = toDate.addingTimeInterval(-86400)
                    self.network.fetchHourlyCharts(ticker: self.symbol, fromDate: self.dateFormatter(date: fromDate), toDate: self.dateFormatter(date: toDate)) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let chartData):
                                print(chartData)
                                self.hourlyChart = chartData
                            case .failure(let error):
                                self.errorMessage = error.localizedDescription
                            }
                            group.leave()
                        }
                    }
                
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    group.leave()
                }
                
            }
        }
        
        group.enter()
        network.fetchEarnings(ticker: symbol) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.earnings = data
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                group.leave()
            }
        }
        
        
        group.enter()
        network.fetchNews(ticker: symbol) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.news = data.filter({ self.isValidNews(news: $0)})
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                group.leave()
            }
        }
        
        group.enter()
        network.fetchPeers(ticker: symbol) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.peers = data.filter({!$0.contains(".")})
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                group.leave()
            }
        }
        
        group.enter()
        network.fetchCharts(ticker: symbol) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.Chart = data
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                        group.leave()
            }
        }
        
        group.enter()
        network.fetchRecommendation(ticker: symbol) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.recommendation = data
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                group.leave()
            }
        }
        
        
        group.enter()
        network.fetchInsiders(ticker: symbol) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.insider = data.data
                    self.insights = self.calculateInsights(data: data.data)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
               self.isLoading = false
           }
        
    }
    
    func updateQuote(){
        self.network.fetchQuotes(ticker: symbol) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.quote = data
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func testData(){
        self.details = mockStockDetails;
        self.quote = mockQuote;
        self.earnings = mockEarnings;
        self.news = mockNews;
        self.peers = mockPeers;
        self.hourlyChart = mockChartResponse;
        self.Chart = mockChartResponse;
        self.recommendation = mockRecommendations;
        self.insider = mockInsider;
        self.insights = calculateInsights(data: self.insider)
        self.isLoading = false
        
    }
    
    func calculateInsights(data: [Insider]) -> Insights{
        return Insights(
            msprPositive: data.filter({$0.mspr >= 0}).reduce(0, {$0 + $1.mspr}),
            msprNegative: data.filter({$0.mspr < 0}).reduce(0, {$0 + $1.mspr}),
            changePositive: data.filter({$0.change >= 0}).reduce(0, {$0 + $1.change}),
            changeNegative: data.filter({$0.change < 0}).reduce(0, {$0 + $1.change}))
    }
    
    func dateFormatter(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Specify the format you want
        return dateFormatter.string(from: date)
    }
    
    
    func isValidNews(news: News) -> Bool{
        return isValidData(news.headline) && isValidData(news.source) && isValidData(news.url) && isValidData(news.summary) && isValidData(news.image)
    }
    
    func isValidData(_ a: String) -> Bool{
        return a != ""
    }
    
    
   
   
    
}

    

