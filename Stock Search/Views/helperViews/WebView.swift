//
//  WebView.swift
//  Stock Search
//
//  Created by Babloo Yerram on 4/26/24.
//

import SwiftUI
import WebKit

struct HttpView: UIViewRepresentable {
    @Binding var title: String
    @State var response: ChartJSData;
    let resourceName: String
    let resourceType: String
    let subdirectory: String
    var loadStatusChanged: ((Bool, Error?) -> Void)? = nil

    func makeCoordinator() -> HttpView.Coordinator {
        Coordinator(self, response:response)
    }

    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.navigationDelegate = context.coordinator
        view.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1"
        if let url = Bundle.main.url(forResource: resourceName, withExtension: resourceType, subdirectory: subdirectory) {
            view.loadFileURL(url, allowingReadAccessTo: url)
            let request = URLRequest(url: url)
            view.load(request)
            print("done")
        }
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }

    func onLoadStatusChanged(perform: ((Bool, Error?) -> Void)?) -> some View {
        var copy = self
        copy.loadStatusChanged = perform
        return copy
    }
    
    

    
    

    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: HttpView
        let response: ChartJSData

        init(_ parent: HttpView, response: ChartJSData) {
            self.parent = parent
            self.response = response
        }

        func webView(_ httpView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.loadStatusChanged?(true, nil)
        }

        func webView(_ httpView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.title = httpView.title ?? ""
            parent.loadStatusChanged?(false, nil)
            let script = "loadChart('\(self.response.serialize())')"
            httpView.evaluateJavaScript(script) { result, error in
                            if let error = error {
                                print("JavaScript execution error: \(error)")
                            }
                        }
        }

        func webView(_ httpView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.loadStatusChanged?(false, error)
        }
    }
}

struct WebView: View {
    @State var response: ChartJSData;
    @State var title: String = ""
    @State var error: Error? = nil
    

    var body: some View {
  
            HttpView(title: $title,
                     response: response,
                     resourceName: "index",
                     resourceType: "html",
                     subdirectory: "charts")
//            .onLoadStatusChanged { loading, error in
//                if loading {
//                    self.title = "Loading…"
//                    print("Loading")
//                }
//                else {
//                    if let error = error {
//                        self.error = error
//                        if self.title.isEmpty {
//                            self.title = "Error"
//                        }
//                    }
//                    else if self.title.isEmpty {
//                        self.title = "Some Place"
//                    }
//                    print("Done")
//                }
//                
//            }
//        
    }
}




#Preview {
    WebView(response: ChartJSData(stock: "AAPL", chartType: "hourly", chartResponse: mockChartResponse))
}
