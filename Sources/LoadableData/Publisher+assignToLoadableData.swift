//
//  Publisher+assignToLoadableData.swift
//
//
//  Created by Dmitry Matyukhin on 20/02/2024.
//

import Foundation
import Combine
import CombineSchedulers

extension Publisher {
    public func assign<Root: AnyObject>(loadableKeypath keyPath: ReferenceWritableKeyPath<Root, LoadableData<Self.Output>>,
                                        on object: Root,
                                        scheduler: AnySchedulerOf<DispatchQueue> = .main,
                                        isSeamless: Bool = false) -> AnyCancellable
    {
        self
            .receive(on: scheduler)
            .handleEvents(receiveSubscription: { [weak object] _ in
                if !isSeamless {
                    object?[keyPath: keyPath] = .loading
                }
            })
            .sink { [weak object] result in
                switch result {
                case .failure(let error):
                    if !isSeamless {
                        object?[keyPath: keyPath] = .failedToLoad(error)
                    }
                case .finished: ()
                }
            } receiveValue: { [weak object] value in
                object?[keyPath: keyPath] = .available(value)
            }
    }
}
