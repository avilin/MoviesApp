//
//  Dynamic.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 1/5/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class Binder<T> {

    typealias OnUpdateEvent = (T) -> Void
    var onModelUpdated: OnUpdateEvent?
    var onViewUpdated: OnUpdateEvent?

    var value: T {
        didSet {
            onModelUpdated?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    // MARK: - Bindings
    func bindOnModelUpdated(_ onModelUpdated: OnUpdateEvent?) {
        self.onModelUpdated = onModelUpdated
    }

    func bindAndFireOnModelUpdated(_ onModelUpdated: OnUpdateEvent?) {
        self.onModelUpdated = onModelUpdated
        onModelUpdated?(value)
    }

    func bindOnViewUpdated(_ onViewUpdated: OnUpdateEvent?) {
        self.onViewUpdated = onViewUpdated
    }

}
