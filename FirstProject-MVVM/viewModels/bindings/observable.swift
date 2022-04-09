//
//  observable.swift
//  FirstProject-MVVM
//
//  Created by Айдимир Магомедов on 08.04.2022.
//

import Foundation

class Observable<T> {
    private var listener : ((T) -> Void)?
    func bind(_ listener : ((T) -> Void)?){
        listener?(value)
        self.listener = listener
    }
    var value : T {
        didSet{
            listener?(value)
        }
    }
    init(value : T){
        self.value = value
    }
}
