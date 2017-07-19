//
//  ToDoStore.swift
//  RxViewController
//
//  Created by chenyong on 2017/7/18.
//  Copyright © 2017年 chenyong. All rights reserved.
//

import Foundation

let dummy = [
    "Buy the milk",
    "Take my dog",
    "Rent a car"
]

struct TodoStore {
    static let shared = TodoStore()
    func getToDoItems(completionHandler: (([String]) -> Void)?) {
        //模拟网络请求, 设2秒延迟
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { 
            completionHandler?(dummy)
        }
    }
}
