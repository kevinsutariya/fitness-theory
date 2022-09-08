//
//  MainMenuItem.swift
//  Fitness Theory
//
//  Created by Jay Borania on 23/07/22.
//

import Foundation

struct MainMenuItem {
    let id: Int
    let item_name: String
    let items: [MenuItem]
    
    init(id: Int, item_name: String, items: [MenuItem]) {
        self.id = id
        self.item_name = item_name
        self.items = items
    }
}

struct MenuItem {
    let item_description: String
    let item_image_name: String
    
    init(description: String, image_name: String) {
        self.item_description = description
        self.item_image_name = image_name
    }
}
