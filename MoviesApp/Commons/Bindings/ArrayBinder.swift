//
//  ArrayBinder.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import Foundation

class ArrayBinder<T> {

    typealias OnAssignEvent = ([T]) -> Void
    typealias OnChangedValueAtIndex = (Int) -> Void
    var onValueAssigned: OnAssignEvent?
    var onElementAdded: OnChangedValueAtIndex?
    var onElementRemoved: OnChangedValueAtIndex?
    var onElementUpdated: OnChangedValueAtIndex?

    private(set) var value: [T]

    init(_ value: [T]) {
        self.value = value
    }

    // MARK: - Bindings
    func bindOnValueAssigned(_ onValueAssigned: OnAssignEvent?) {
        self.onValueAssigned = onValueAssigned
    }

    func bindAndFireOnValueAssigned(_ onValueAssigned: OnAssignEvent?) {
        self.onValueAssigned = onValueAssigned
        onValueAssigned?(value)
    }

    func bindOnElementAdded(_ onElementAdded: OnChangedValueAtIndex?) {
        self.onElementAdded = onElementAdded
    }

    func bindOnElementRemoved(_ onElementRemoved: OnChangedValueAtIndex?) {
        self.onElementRemoved = onElementRemoved
    }

    func bindOnElementUpdated(_ onElementUpdated: OnChangedValueAtIndex?) {
        self.onElementUpdated = onElementUpdated
    }

    // MARK: - Custom Accessors
    func assignValue(value: [T]) {
        self.value = value
        onValueAssigned?(value)
    }

    func addElement(_ element: T) {
        value.append(element)
        onElementAdded?(value.count - 1)
    }

    func removeElement(at index: Int) {
        if case 0 ..< value.count = index {
            value.remove(at: index)
            onElementRemoved?(index)
        }
    }

    func updateElement(_ element: T, at index: Int) {
        if case 0 ..< value.count = index {
            value[index] = element
            onElementUpdated?(index)
        }
    }

}
