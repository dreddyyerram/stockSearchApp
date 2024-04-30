//
//  SmallNewsView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/29/24.
//

import SwiftUI
import Kingfisher

struct SmallNewsView: View {
    let news : News
    
    var body: some View {
        HStack(alignment:.top){
            VStack(alignment:.leading) {
                HStack(alignment: .top){
                    Text(news.source).font(.caption).foregroundColor(.secondary).fontWeight(.bold)
                    Text(timeSince(news.datetime)).font(.caption).foregroundColor(.secondary)
                    Spacer()
                }.padding(.bottom, 0.4)
                .padding(.top, 5)
                Text(news.headline)
                    .font( .system(size: 15, weight: .bold))
                    .lineLimit(3)
                
            }
            Spacer()
            VStack {
                KFImage(URL(string: news.image))
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(height:85)
                    .cornerRadius(8)
            }
            
        }
        .padding(.vertical, 5)
    }
    
}


#Preview {
    SmallNewsView(news: mockNews[0])
}
