//
//  MemoDataModel.swift
//  SwiftUIMemoDemoApp
//
//  Created by ryota on 2021/08/22.
//

import Foundation
import RealmSwift

final class MemoDao{
    static let dao = RealmDaoHelper<MemoDto>()
    static func addMemo(name: String) {
       let memo = MemoDto()
       dao.add(object: memo)
    }
    
    static func findAll() -> Results<MemoDto> {
        return dao.findAll()
    }
    
    static func addMemo(memo:MemoDto) {
        dao.add(object: memo)
    }
    
    static func deleteMemo(memo: MemoDto) {
        dao.delete(object: memo)
    }

    static func deleteAllMemo() {
            dao.deleteAll()
    }
}
