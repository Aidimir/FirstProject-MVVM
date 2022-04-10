//
//  observable.swift
//  FirstProject-MVVM
//
//  Created by Айдимир Магомедов on 08.04.2022.
//

import Foundation

class Observable<T> {
    typealias Listener = (T) -> ()
    private var listeners: [Listener] = []
    init(_ v: T) {
        value = v
    }
    var value: T {
        didSet {
            for l in listeners { l(value) } }
    }
    func bind(l: @escaping Listener) {
        listeners.append(l)
        l(value)
    }
    func addListener(l: @escaping Listener) {
        listeners.append(l)
    }
}
