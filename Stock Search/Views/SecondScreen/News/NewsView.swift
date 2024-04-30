import SwiftUI
import Kingfisher

struct NewsView: View {
    @StateObject var viewModel: StockSearchViewModel
    @State private var showDetail: Bool = false
    @State private var selectedArticle: News = mockNews[0]
    
    var body: some View {
        if(!viewModel.isLoading){
            ScrollView{
                VStack(alignment: .leading, spacing: 0) {
                    Text("News").font(.title2).fontWeight(.regular)
                    if let firstNews = viewModel.news.first{
                        VStack(alignment:.leading){
                            LargeNewsView(news: firstNews)
                                .padding(.bottom, 12).padding(.top, 0)
                        }
                        .onTapGesture {
                            self.selectedArticle = firstNews
                            self.showDetail = true
                        }.padding(.top, 0)
                    }
                    
                    Divider()
                    ForEach(viewModel.news.dropFirst(), id: \.id) { article in
                        SmallNewsView(news: article)
                            .onTapGesture {
                                self.selectedArticle = article
                                self.showDetail = true
                            }
                        
                    }.padding(.vertical, 5)
                }
                .sheet(isPresented: $showDetail) {
                
                    NewsSheetView(isPresented: $showDetail, newsItem: $selectedArticle)
                    
                }.padding()
            }
        }
        

    }
        
}


#Preview {
    NewsView(viewModel: StockSearchViewModel(symbol: "AAPL"))
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
