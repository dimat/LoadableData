//
//  LoadingView.swift
//
//
//  Created by Dmitry Matyukhin on 20/02/2024.
//

import SwiftUI

public struct LoadingView: View {
    var debugMessage: String
    public var body: some View {
        VStack {
            ProgressView()
            
            // we can add an additional launch argument to hide it even further
            #if DEBUG
            Text(debugMessage)
                .font(.caption)
                .opacity(0.3)
            #endif
        }
    }
    
    public init(debugMessage: String = "") {
        self.debugMessage = debugMessage
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
        
        LoadingView(debugMessage: "fetching user profile")
    }
}
