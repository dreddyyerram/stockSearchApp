//
//  Network.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/17/24.
//

import Foundation
import Alamofire

struct Network{
    
    func fetchQuotes(ticker: String, completion: @escaping (Result<Quote, Error>) -> Void) {
        let url: String = Constants.baseUrl.appending("/stock/quote?symbol=\(ticker)")
        
        AF.request(url).responseDecodable(of: Quote.self) { response in
            switch response.result {
            case .success(let quoteData):
                completion(.success(quoteData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchDetails(ticker: String, completion: @escaping (Result<StockDetails, Error>) -> Void) {
        let url: String = Constants.baseUrl.appending("/stock/profile?symbol=\(ticker)")
        
        AF.request(url).responseDecodable(of: StockDetails.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func fetchEarnings(ticker: String, completion: @escaping (Result<[Earnings], Error>) -> Void) {
        let url: String = Constants.baseUrl.appending("/stock/earnings?symbol=\(ticker)")
        
        AF.request(url).responseDecodable(of: [Earnings].self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func fetchNews(ticker: String, completion: @escaping (Result<[News], Error>) -> Void) {
        let url: String = Constants.baseUrl.appending("/stock/news?symbol=\(ticker)")
        
        AF.request(url).responseDecodable(of: [News].self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPeers(ticker: String, completion: @escaping (Result<Peers, Error>) -> Void) {
        let url: String = Constants.baseUrl.appending("/stock/peers?symbol=\(ticker)")
        
        AF.request(url).responseDecodable(of: Peers.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
  
    func fetchCharts(ticker: String, completion: @escaping (Result<ChartResponse, Error>) -> Void) {
        let url: String = Constants.baseUrl.appending("/stock/charts?symbol=\(ticker)")
        
        AF.request(url).responseDecodable(of: ChartResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.success(mockChartResponse))
            }
        }
    }
    
    func fetchHourlyCharts(ticker: String, fromDate: String, toDate: String, completion: @escaping (Result<ChartResponse, Error>) -> Void) {
        
        let url: String = Constants.baseUrl.appending("/stock/charts?symbol=\(ticker)&from=\(fromDate)&to=\(toDate)&span=hour")
        
        AF.request(url).responseDecodable(of: ChartResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.success(mockChartResponse))
            }
        }
    }
    
    func fetchRecommendation(ticker: String, completion: @escaping (Result<[Recommendation], Error>) -> Void) {
        let url: String = Constants.baseUrl.appending("/stock/recommendation?symbol=\(ticker)")
        
        AF.request(url).responseDecodable(of: [Recommendation].self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func fetchInsiders(ticker: String, completion: @escaping (Result<InsiderResponse, Error>) -> Void) {
        let url: String = Constants.baseUrl.appending("/stock/insider?symbol=\(ticker)")
        
        AF.request(url).responseDecodable(of: InsiderResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
