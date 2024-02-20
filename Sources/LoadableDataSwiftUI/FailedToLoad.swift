//
//  FailedToLoad.swift
//
//
//  Created by Dmitry Matyukhin on 20/02/2024.
//

import SwiftUI

public struct FailedToLoad: View {
    var error: Error?
    var onRetry: () -> Void
    
    public init(error: Error? = nil, onRetry: @escaping () -> Void) {
        self.error = error
        self.onRetry = onRetry
    }
    
    public var body: some View {
        VStack {
            Text("Failed to load")
                .font(.body)
            #if DEBUG
            if let error {
                Text(error.localizedDescription)
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            #endif
            Button {
                onRetry()
            } label: {
                Text("Retry")
            }
            .buttonStyle(.bordered)
        }
    }
}

struct FailedToLoad_Previews: PreviewProvider {
    static var previews: some View {
        FailedToLoad(onRetry: {})
    }
}
