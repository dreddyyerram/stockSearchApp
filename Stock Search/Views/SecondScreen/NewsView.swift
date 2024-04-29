//
//  NewsView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/20/24.
//

import SwiftUI
import Kingfisher

struct NewsView: View {
    @StateObject var viewModel: StockSearchViewModel
    var body: some View {
        if(!viewModel.isLoading){
            ScrollView{
                VStack(alignment: .leading, spacing: 8) {
                    Text("News").font(.title3)
                    LargeNewsView(newsItem: viewModel.news[0])
                    Divider()
                    ForEach(1..<viewModel.news.count, id: \.self){ index in
                        SmallNewsView(newsItem: viewModel.news[index])
                    }
                    
                    
                }.padding(.horizontal)
            }
        }
    }
}


#Preview {
    NewsView(viewModel: StockSearchViewModel(symbol: "NVDA"))
}

struct LargeNewsView: View {
    var newsItem : News
    @State private var showNewsDetail = false
    var body: some View {
        VStack(alignment: .leading){
            KFImage.url(URL(string: newsItem.image)).resizable().aspectRatio(contentMode: .fit).cornerRadius(12).padding(.vertical)
            HStack{
                Text(newsItem.source).font(.caption).foregroundColor(.secondary).fontWeight(.bold)
                Text(timeSince(newsItem.datetime)).font(.caption).foregroundColor(.secondary)
                Spacer()
            }
    
            Text(newsItem.headline).font(.headline).fontWeight(.bold)
        }.padding(0).onTapGesture {
            showNewsDetail.toggle()
        }.sheet(isPresented: $showNewsDetail){
            NewsSheetView(isPresented: $showNewsDetail, newsItem: newsItem)
        }
    }
}


struct SmallNewsView: View {
    var newsItem : News
    @State private var showNewsDetail = false
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    HStack{
                        Text(newsItem.source).font(.caption2).foregroundColor(.secondary).fontWeight(.bold)
                        Text(timeSince(newsItem.datetime)).font(.caption).foregroundColor(.secondary)
                    }.padding(0)
                    Text(newsItem.headline).font(.headline).fontWeight(.bold).lineLimit(3).padding(.top, 0)
                }.padding(.vertical)
                Spacer()
                
                
                KFImage.url(URL(string: newsItem.image)).frame(width: 100, height: 100).cornerRadius(12).padding(.vertical, 8)
                
                
            }
        }.padding(0).onTapGesture {
            showNewsDetail.toggle()
        }.sheet(isPresented: $showNewsDetail){
            NewsSheetView(isPresented: $showNewsDetail, newsItem: newsItem)
        }
    }
}

func timeSince(_ timestamp: Int) -> String {
        let newsDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let currentDate = Date()
        let components: Set<Calendar.Component> = [.hour, .minute]
        let difference = Calendar.current.dateComponents(components, from: newsDate, to: currentDate)

        var timeComponents = [String]()
        if let hour = difference.hour, hour > 0 {
            let hourPart = "\(hour) hr"
            timeComponents.append(hourPart)
        }
        if let minute = difference.minute, minute > 0 {
            let minutePart = "\(minute) min"
            timeComponents.append(minutePart)
        }
        if timeComponents.isEmpty {
            return "0 min"
        }

        return timeComponents.joined(separator: ", ")
}
