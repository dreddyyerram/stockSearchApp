//
//  WatchlistViewModel.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/17/24.
//

import Foundation
import Alamofire
import SwiftyJSON

final class WatchlistViewModel: ObservableObject{
    
    @Published var watchlist: Watchlist = mockWatchlist
    @Published var isLoading = false;
    @Published var errorMessage: String?
    var network = Network()
    
    
    init(){
        self.fetchWatchlist()
    }
    
    func move(fromOffsets: IndexSet, toOffset: Int){
        watchlist.stocks.move(fromOffsets: fromOffsets, toOffset: toOffset)
        syncWatchlist()
        
    }
    
    func delete(atOffsets: IndexSet){
        watchlist.stocks.remove(atOffsets: atOffsets)
        syncWatchlist()
    }
    
    func deleteStock(stock: String){
        if let index = watchlist.stocks.firstIndex(where: { $0.ticker == stock }) {
            watchlist.stocks.remove(at: index)
            syncWatchlist()
        }
    }
    
    func addStock(stock: StockDetails, quote: Quote){
        let st = WatchlistStock(ticker: stock.ticker, name: stock.name, quote: quote)
        watchlist.stocks.append(st)
        syncWatchlist()
    }
    
    
    
    func updateQuotesForWatchlist() {
        let dispatchGroup = DispatchGroup()

        for index in watchlist.stocks.indices {
            dispatchGroup.enter()
            network.fetchQuotes(ticker: watchlist.stocks[index].ticker) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case .success(let quote):
                        self.watchlist.stocks[index].quote = quote
                    case .failure(let error):
                        print("Failed to fetch quote for \(self.watchlist.stocks[index].ticker): \(error)")
                    }
                    dispatchGroup.leave()
                }
            }
        }
        
        
        
        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
            // All requests are completed, do any final updates or notify UI
            print("All quotes for Watchlist updated")
        }
    }
    
//    func addStockToDB(watchlistStock: WatchlistStock) {
//        let url = Constants.baseUrl.appending("/mongoDb/HW3/WatchList")
//        AF.request(url, method: .post, parameters: watchlistStock, encoder: JSONParameterEncoder.default).response { response in
//            DispatchQueue.main.async {
//                switch response.result {
//                case .success(_):
//                    print("Stock Added To watchlist")
//                case .failure(let error):
//                    self.errorMessage = "Failed to Add stock from watchlist: \(error.localizedDescription)"
//                }
//            }
//        }
//    }
//    
//    func removeStockFromDB(stock: String) {
//        let url = Constants.baseUrl.appending("/mongoDb/HW3/WatchList?ticker=\(stock)")
//        AF.request(url, method: .delete).response { response in
//            DispatchQueue.main.async {
//                switch response.result {
//                case .success(_):
//                    print("Stock removed from watchlist")
//                case .failure(let error):
//                    self.errorMessage = "Failed to remove stock from watchlist: \(error.localizedDescription)"
//                }
//            }
//        }
//    }
    
    
    func syncWatchlist(){
        let url = Constants.baseUrl.appending("/mongoDb/HW3/Watchlist?user=User")
        AF.request(url, method: .put, parameters: watchlist, encoder: JSONParameterEncoder.default).response { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(_):
                    print("Watchlist synced successfully")
                case .failure(let error):
                    self.errorMessage = "Failed to sync portfolio: \(error.localizedDescription)"
                }
            }
        }
    }
    
    
    func fetchWatchlist() {
        isLoading = true
        errorMessage = nil
        
        let url = Constants.baseUrl.appending("/mongoDb/HW3/Watchlist?user=User")
        
        AF.request(url).responseDecodable(of: Watchlist.self) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch response.result {
                case .success(let watchlistData):
                    self.watchlist = watchlistData
                    self.updateQuotesForWatchlist()
                case .failure(let error):
                    self.errorMessage = "Failed to fetch watchlist: \(error.localizedDescription)"
                }
            }
        }
    }
    
}
