//
//  CreateForm.swift
//  Nurture
//
//  Created by Uzoh Okwara on 10/12/21.
//

import UIKit

class CreateForm: Encodable {
    var id: String = UUID().uuidString
    var title: String = ""
    var time: [String] = []
    var days: [String] = []
    var emoji: String = ""
    
    init() {}
    init(id: String, title: String, time: [String], days: [String], emoji: String) {
        self.id = id
        self.title = title
        self.time = time
        self.days = days
        self.emoji = emoji
    }
}
