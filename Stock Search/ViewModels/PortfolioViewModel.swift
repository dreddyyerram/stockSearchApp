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
    
    
    init(){
        self.fetchPortfolio()
    }
    
    func fetchPortfolio() {
        isLoading = true
        errorMessage = nil
        
        let url = Constants.baseUrl.appending("/mongoDb/HW3/Portfolio?user=User")
        
        AF.request(url).responseDecodable(of: Portfolio.self) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch response.result {
                case .success(let portfolioData):
                    self.portfolio = portfolioData
                case .failure(let error):
                    self.errorMessage = "Failed to fetch portfolio: \(error.localizedDescription)"
                }
            }
        }
    }
    
}

    

