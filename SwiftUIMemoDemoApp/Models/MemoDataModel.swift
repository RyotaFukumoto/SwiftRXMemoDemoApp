//
//  MemoDataModel.swift
//  SwiftUIMemoDemoApp
//
//  Created by ryota on 2021/08/22.
//

import Foundation
import RealmSwift

class MemoDataModel: Object,Identifiable {
    @objc dynamic var text = ""
    @objc dynamic var postedDate = Date()
}

extension MemoDataModel {
    private static var config = Realm.Configuration(schemaVersion: 1)
    private static var realm = try! Realm(configuration: config)

    static func findAll() -> Results<MemoDataModel> {
        realm.objects(self)
    }
    
    static func add(_ memo:MemoDataModel) {
        try! realm.write {
            realm.add(memo)
        }
    }
    static func delete(_ memo: MemoDataModel) {
            try! realm.write {
                realm.delete(memo)
            }
        }

        static func delete(_ memos: [MemoDataModel]) {
            try! realm.write {
                realm.delete(memos)
            }
        }
}
