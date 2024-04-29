//
//  NewsSheetView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/23/24.
//

import SwiftUI

struct NewsSheetView: View {
    @Binding var isPresented: Bool
    let newsItem : News

    var body: some View {
        VStack {
            HStack {
                Spacer() // Pushes the button to the right
                
                Button(action: {
                    // Dismiss the sheet
                    self.isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.secondary).fontWeight(.bold)
                }
                .padding()
                .accessibilityLabel(Text("Close"))
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text(newsItem.source)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(Date(timeIntervalSince1970: TimeInterval(newsItem.datetime)).formatted(.dateTime.month(.wide).day().year())).font(.caption).foregroundColor(.secondary).padding(.bottom, 6)
        
                    Divider()
                    
                    Text(newsItem.headline)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.vertical, 2)
                    
                    Text(newsItem.summary).font(.footnote)
                    
                    HStack{
                        Text("For more details click").foregroundStyle(.secondary).font(.footnote)
                        Link("here ", destination: URL(string: newsItem.url)!).font(.footnote)
                    }
                    
                    HStack{
                        Button(action: shareOnTwitter) {
                            Image("tw").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }

                        Button(action: shareOnFacebook) {
                            Image("fb").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                    }
                    
                }
                .padding()
                
            }
            
        }.onAppear(perform: {
            print(newsItem)
        })
    }
    
     func shareOnTwitter() {
         let url = URL(string: "https://twitter.com/intent/tweet?text=\(newsItem.headline) \(newsItem.url)")!
            UIApplication.shared.open(url)
        
      
    }

    func shareOnFacebook() {
        let url = URL(string: "https://www.facebook.com/sharer/sharer.php?u=\(newsItem.url)")!
        UIApplication.shared.open(url)
    }
}

#Preview {
    NewsSheetView(isPresented: .constant(false), newsItem: mockNews[0])
}
