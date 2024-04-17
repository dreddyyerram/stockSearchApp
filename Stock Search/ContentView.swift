//
//  ContentView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/13/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    Section(header: Text("Portfolio")) {
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Net Worth")
                                    Text("$25000.00")
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("Cash Balance")
                                    Text("$25000.00")
                                }
                            }
                            PortfolioView()
                        }
                        
                    }
                    Section(header: Text("Favourites")) {
                    }
                    
                    
                    Section() {
                        Link("Powered by Finnhub.io",
                             destination: URL(string: "https://finnhub.io")!)
                        .fontWeight(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                    }
                    
                    Button(action: {
                        print("logout")
//                        service.fetchPortfolio();
                    }) {
                        Text("Logout")
                    }
                }
                .navigationTitle("Stocks")
                .toolbar{
                    EditButton()
                }
            }
            
            
        }
        
        
    }
}

#Preview {
    ContentView()
}
