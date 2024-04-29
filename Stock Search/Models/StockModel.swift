//
//  StockModel.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/15/24.
//

import Foundation


struct Portfolio: Decodable, Hashable, Encodable {
    var stocks: [PortfolioStock]
    var balance: Double
    var user: String
    var networth: Double
}

struct Watchlist: Decodable, Hashable, Encodable {
    var stocks: [WatchlistStock]
    var user: String
}

struct PortfolioStock: Decodable, Hashable, Encodable {
    var ticker: String
    var name: String
    var quantity: Int
    var total_price: Double
    var current_price: Double
    var avg_price: Double
    var change: Double
    var mrkt_value: Double
    var percent: Double
}

struct WatchlistStock: Decodable, Hashable, Encodable {
    var ticker: String
    var name: String
    var quote: Quote
    
}

struct Quote: Decodable, Hashable, Encodable {
    var c: Double
    var d: Double
    var dp: Double
    var h: Double
    var l: Double
    var o: Double
    var pc: Double
    var t: Double
}



struct SearchResult: Decodable, Encodable, Hashable {
    var symbol: String
    var description: String
}

struct AutoSearch: Decodable, Encodable, Hashable {
    var result: [SearchResult]
}


struct StockDetails: Decodable, Encodable, Hashable {
    var name: String
    var ticker: String
    var exchange: String
    var marketCapitalization: Double
    var shareOutstanding: Double
    var ipo: String
    var phone: String
    var weburl: String
    var logo: String
    var country: String
    var currency: String
    var estimateCurrency: String
    var finnhubIndustry: String
}

struct Earnings: Decodable, Encodable, Hashable {
    var actual: Double
    var estimate: Double
    var period: String
    var quarter: Int
    var surprise: Double
    var surprisePercent: Double
    var symbol: String
    var year: Int
}

struct News: Decodable, Encodable, Hashable, Identifiable {
    var id: Int
    var category: String
    var datetime: Int // Consider using Date
    var headline: String
    var image: String
    var related: String
    var source: String
    var summary: String
    var url: String
}

typealias Peers = [String]

struct ChartData: Decodable, Encodable, Hashable {
    var c: Double
    var h: Double
    var l: Double
    var o: Double
    var t: Int
    var v: Int
    var vw: Double
    var n: Int
}

struct ChartResponse: Decodable, Encodable, Hashable {
    var ticker: String
    var results: [ChartData]
}

struct Stock: Decodable, Encodable, Hashable {
    var ticker: String
    var name: String
    var currentPrice: Double
    var avgPrice: Double?
    var change: Double?
    var mrktValue: Double?
    var totalPrice: Double
    var quantity: Int
}

struct Recommendation: Decodable, Encodable, Hashable {
    var buy: Int
    var hold: Int
    var period: String
    var sell: Int
    var strongBuy: Int
    var strongSell: Int
    var symbol: String
}

struct Insider: Decodable, Encodable, Hashable {
    var symbol: String
    var year: Int
    var month: Int
    var change: Double
    var mspr: Double
}

struct Insights: Decodable, Encodable, Hashable {
    var msprPositive: Double
    var msprNegative: Double
    var changePositive: Double
    var changeNegative: Double
}

struct InsiderResponse: Decodable, Encodable, Hashable {
    var data: [Insider]
}


class ChartJSData: Encodable {
    var stock: String
    var chartType : String
    var chartResponse: ChartResponse?
    var recommends: [Recommendation]?
    var earnings: [Earnings]?
    var quote : Double = 0
    
    init(stock: String, chartType: String, chartResponse: ChartResponse) {
        self.stock = stock
        self.chartType = chartType
        self.chartResponse = chartResponse
        self.recommends = []
        self.earnings = []
    
    }
    
    init(stock: String, chartType: String, chartResponse: ChartResponse, quote: Quote) {
        self.stock = stock
        self.chartType = chartType
        self.chartResponse = chartResponse
        self.recommends = []
        self.earnings = []
        self.quote = quote.d
    
    }
    
    init(stock: String, chartType: String, recommends: [Recommendation]) {
        self.stock = stock
        self.chartType = chartType
        self.recommends = recommends
        self.chartResponse = nil
        self.earnings = []
    }
    
    init(stock: String, chartType: String, earnings: [Earnings]) {
        self.stock = stock
        self.chartType = chartType
        self.earnings = earnings
        self.chartResponse = nil
        self.recommends = []
    }
    
    func serialize() -> String {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(self)
        return String(data: data, encoding: .utf8)!
    }
}

let mockPortfolio = Portfolio(stocks: [], balance: 25000, user: "User", networth: 25000)

let mockWatchlist = Watchlist(stocks:[], user: "User")


let mockStockDetails = StockDetails(name: "Apple Inc.", ticker: "AAPL", exchange: "NASDAQ", marketCapitalization: 2000000000000, shareOutstanding: 1000000000, ipo: "1980", phone: "1234567890", weburl: "www.apple.com", logo: "https://static2.finnhub.io/file/publicdatany/finnhubimage/stock_logo/AAPL.png", country: "USA", currency: "USD", estimateCurrency: "USD", finnhubIndustry: "Technology")

let mockPeers = ["GOOGL", "MSFT", "AMZN", "FB"]


let mockNews = [
    News(id: 1, category: "Technology", datetime: 1713617340, headline: "Apple Inc. (AAPL) stock rises 10% in a week", image: "https://media.zenfs.com/en/ibd.com/f287385a5f84c1d1e13191d4ae92d9fb", related: "AAPL", source: "CNBC", summary: "Apple Inc. (AAPL) stock rises 10% in a week", url: "https://apple.com"),
    News(id: 2, category: "Technology", datetime: 1713613842, headline: "Apple Inc. (AAPL) stock rises 10% in a week", image: "https://media.zenfs.com/en/moneywise_327/c0853b6f53fc22b1319ab54211a49414", related: "AAPL", source: "CNBC", summary: "Apple Inc. (AAPL) stock rises 10% in a week", url: "https://apple.com"),
    News(id: 3, category: "Technology", datetime: 1713611760, headline: "Apple Inc. (AAPL) stock rises 10% in a week", image: "https://g.foolcdn.com/editorial/images/773226/friends-laughing-over-drinks-on-a-boat-soda-bottle.jpg", related: "AAPL", source: "CNBC", summary: "Apple Inc. (AAPL) stock rises 10% in a week sklcnakc kmlck smaLcm lma ;lmcl;msa;d lkcmlkadmslkcm klnksldnmclkam kncz kldncx klnzsdkl sdmklsdmlk; ldsn nkn sdnmvk dmsac msla;  mlkmdc;lasm;lcm l;ml;dmcl;amD:L ml;mcl;adml;dcm ;lmcla;dsmcls;a ;lmsl;dml;s l;ml;d  d vdmakmldma cdm;lsakdmd;slacm;lka d;lsmc;ldmdsl; l;msd;lmvlds dl;dsmldmdl;ml;dmvl;dml;dsm", url: "https://apple.com")
]

let mockChartResponse = ChartResponse(
    ticker: "AAPL",
    results: [
        ChartData(c: 172.18, h: 172.2, l: 172, o: 172.2, t: 1711353600000, v: 12304, vw: 172.0921, n: 623),
        ChartData(c: 171.71, h: 172.17, l: 171.68, o: 172.17, t: 1711357200000, v: 26367, vw: 171.8675, n: 670),
        ChartData(c: 171.3, h: 171.85, l: 171.3, o: 171.7, t: 1711360800000, v: 22325, vw: 171.6108, n: 714),
        ChartData(c: 171.19, h: 171.41, l: 171.07, o: 171.39, t: 1711364400000, v: 99751, vw: 171.1989, n: 2031),
        ChartData(c: 171, h: 172.27, l: 170.9, o: 171.4, t: 1711368000000, v: 322034, vw: 171.4896, n: 8091),
        ChartData(c: 170.18, h: 171.1, l: 169.45, o: 171.02, t: 1711371600000, v: 9431437, vw: 170.07, n: 129030),
        ChartData(c: 170.55, h: 170.61, l: 169.77, o: 170.18, t: 1711375200000, v: 7647322, vw: 170.1026, n: 164914),
        ChartData(c: 170.62, h: 170.765, l: 170.09, o: 170.54, t: 1711378800000, v: 5080570, vw: 170.4135, n: 165102),
        ChartData(c: 170.99, h: 171.15, l: 170.38, o: 170.62, t: 1711382400000, v: 4474779, vw: 170.714, n: 56526),
        ChartData(c: 171.468, h: 171.52, l: 170.985, o: 171, t: 1711386000000, v: 4435363, vw: 171.3007, n: 54815),
        ChartData(c: 171.448, h: 171.61, l: 171.235, o: 171.465, t: 1711389600000, v: 3773224, vw: 171.4493, n: 44379),
        ChartData(c: 170.85, h: 171.94, l: 170.79, o: 171.45, t: 1711393200000, v: 8727515, vw: 171.2945, n: 90738),
        ChartData(c: 170.85, h: 171.1496, l: 170.75, o: 170.86, t: 1711396800000, v: 1640823, vw: 170.8539, n: 3318),
        ChartData(c: 170.88, h: 170.93, l: 170.05, o: 170.9078, t: 1711400400000, v: 33623, vw: 170.856, n: 1173),
        ChartData(c: 170.93, h: 170.9999, l: 170.83, o: 170.8301, t: 1711404000000, v: 32627, vw: 170.9108, n: 873),
        ChartData(c: 170.92, h: 170.98, l: 170.83, o: 170.9, t: 1711407600000, v: 18995, vw: 170.9076, n: 673)
    ]
)

let mockStock = [
    Stock(ticker: "AAPL", name: "Apple Inc.", currentPrice: 150, avgPrice: 140, change: 10, mrktValue: 1500, totalPrice: 1400, quantity: 10),
    Stock(ticker: "MSFT", name: "Microsoft Corporation", currentPrice: 300, avgPrice: 290, change: 10, mrktValue: 3000, totalPrice: 2900, quantity: 10)
]

let mockInsider = [
    Insider(symbol: "AAPL", year: 2024, month: 4, change: 1.5, mspr: 150.00),
    Insider(symbol: "MSFT", year: 2024, month: 3, change: 2.0, mspr: 300.00)
]

let mockInsights = Insights(msprPositive: 200.00, msprNegative: 150.00, changePositive: 5.00, changeNegative: -3.00)

let mockInsiderResponse = InsiderResponse(data: mockInsider)

let mockEarnings = [
    Earnings(actual: 2.18, estimate: 2.1401, period: "2023-12-31", quarter: 1, surprise: 0.0399, surprisePercent: 1.8644, symbol: "AAPL", year: 2024),
    Earnings(actual: 1.46, estimate: 1.4194, period: "2023-09-30", quarter: 4, surprise: 0.0406, surprisePercent: 2.8604, symbol: "AAPL", year: 2023),
    Earnings(actual: 1.26, estimate: 1.2183, period: "2023-06-30", quarter: 3, surprise: 0.0417, surprisePercent: 3.4228, symbol: "AAPL", year: 2023),
    Earnings(actual: 1.52, estimate: 1.4623, period: "2023-03-31", quarter: 2, surprise: 0.0577, surprisePercent: 3.9458, symbol: "AAPL", year: 2023)
]

let mockRecommendations = [
    Recommendation(buy: 20, hold: 14, period: "2024-04-01", sell: 2, strongBuy: 11, strongSell: 0, symbol: "AAPL"),
    Recommendation(buy: 20, hold: 14, period: "2024-03-01", sell: 2, strongBuy: 12, strongSell: 0, symbol: "AAPL"),
    Recommendation(buy: 19, hold: 13, period: "2024-02-01", sell: 2, strongBuy: 12, strongSell: 0, symbol: "AAPL"),
    Recommendation(buy: 22, hold: 13, period: "2024-01-01", sell: 1, strongBuy: 12, strongSell: 0, symbol: "AAPL")
]

let mockQuote = Quote(
    c: 169.3,
    d: -0.59,
    dp: -0.3473,
    h: 171.34,
    l: 169.19,
    o: 169.87,
    pc: 169.89,
    t: 1714161601
)
