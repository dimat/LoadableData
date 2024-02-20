//
//  LoadableView.swift
//  
//
//  Created by Dmitry Matyukhin on 20/02/2024.
//

import SwiftUI
import LoadableData

public struct LoadableView<Data, Content: View>: View {
    public init(data: Binding<LoadableData<Data>>,
         debugMessage: String = "",
         placeholderData: Data? = nil,
         onRefresh: @escaping () -> Void,
         @ViewBuilder content: @escaping (Data) -> Content)
    {
        self._data = data
        self.debugMessage = debugMessage
        self.onRefresh = onRefresh
        self.content = content
        
        self.placeholderData = placeholderData
    }
    
    @Binding var data: LoadableData<Data>
    var debugMessage: String = ""
    var onRefresh: () -> Void
    var placeholderData: Data?
    @ViewBuilder var content: (Data) -> Content
    
    @ViewBuilder
    var loadingView: some View {
        if let placeholderData {
            content(placeholderData)
                .redacted(reason: .placeholder)
        } else {
            LoadingView(debugMessage: debugMessage)
        }
    }
    
    public var body: some View {
        switch data {
        case .available(let data):
            content(data)
        case .failedToLoad(let error):
            FailedToLoad(error: error, onRetry: onRefresh)
        case .notAvailable:
            loadingView
                .onAppear {
                    if case .loading = data {
                        return
                    }
                    onRefresh()
                }
        case .loading:
            loadingView
        }
    }
}
