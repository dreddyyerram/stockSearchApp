//
//  LargeNewsView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/29/24.
//

import SwiftUI
import Kingfisher

struct LargeNewsView: View {
    let news : News
    var body: some View {
        VStack(alignment: .leading){
            KFImage.url(URL(string: news.image)).resizable().aspectRatio(contentMode: .fit).cornerRadius(12).padding(.vertical)
            HStack{
                Text(news.source).font(.caption).foregroundColor(.secondary).fontWeight(.bold)
                Text(timeSince(news.datetime)).font(.caption).foregroundColor(.secondary)
                Spacer()
            }.padding(.bottom, 0)
    
            Text(news.headline).font(.headline).fontWeight(.bold).foregroundColor(.black)
        }.padding(0)
    }
}
#Preview {
    LargeNewsView(news: mockNews[0])
}
