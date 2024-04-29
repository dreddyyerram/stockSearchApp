//
//  AutoCompleteViewModel.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/18/24.
//

import Foundation
import Alamofire
import SwiftyJSON

final class AutoCompleteViewModel: ObservableObject{
        @Published var searchResults: [SearchResult] = []
        @Published var errorMessage: String?
        var network = Network()
        private var currentSearch: URLSessionDataTask?
        
        
        func search(query: String) {
            currentSearch?.cancel()
            if query.isEmpty {
                return
            }
            let url: String = Constants.baseUrl.appending("/stock/search?symbol=\(query)")
            print("searching for \(query)")
            currentSearch = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(AutoSearch.self, from: data)
                    DispatchQueue.main.async {
                        self.searchResults = results.result.filter({!$0.symbol.contains(".")})
                    }
                } catch {
                    print("error: ", error)
                }
            }
            currentSearch?.resume()
                
        }
}
