//
//  MemoDto.swift
//  SwiftUIMemoDemoApp
//
//  Created by ryota on 2021/08/23.
//

import Foundation
import RealmSwift

class MemoDto: Object,Identifiable {
    @objc dynamic var text = ""
    @objc dynamic var postedDate = Date()
    override static func primaryKey() -> String? {
            return "text"
        }
}
