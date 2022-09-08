//
//  NoteItem.swift
//  Fitness Theory
//
//  Created by Jay Borania on 24/07/22.
//

import Foundation

struct NoteItem {
    let note_id: Int
    let note_title: String
    let note_description: String
    var is_open = false
    
    init(note_id: Int, note_title: String, note_description: String) {
        self.note_id = note_id
        self.note_title = note_title
        self.note_description = note_description
    }
}
