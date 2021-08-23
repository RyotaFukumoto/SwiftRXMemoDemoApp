//
//  MemoViewModel.swift
//  SwiftUIMemoDemoApp
//
//  Created by ryota on 2021/08/22.
//

import Foundation
import Combine

class MemoViewModel: ObservableObject {

    @Published private(set) var memos: [MemoDto] = Array(MemoDao.findAll())
    @Published var memoTextField = ""
    @Published var deleteMemo: MemoDto?
    @Published var isDeleteAllTapped = false

    private var addMemoTask: AnyCancellable?
    private var deleteMemoTask: AnyCancellable?
    private var deleteAllMemoTask: AnyCancellable?

    init() {
        addMemoTask = self.$memoTextField
            .sink() { text in
                guard !text.isEmpty else {
                    return
                }
                let memo = MemoDto()
                memo.text = text
                self.memos.append(memo)
                MemoDao.addMemo(memo: memo)
            }
        deleteMemoTask = self.$deleteMemo
            .sink() { memo in
                guard let memo = memo else {
                    return
                }
                if let index = self.memos.firstIndex(of: memo) {
                    self.memos.remove(at: index)
                    MemoDao.deleteMemo(memo: memo)
                }
            }
        deleteAllMemoTask = self.$isDeleteAllTapped
            .sink() { isDeleteAllTapped in
                if (isDeleteAllTapped) {
                    MemoDao.deleteAllMemo()
                    self.memos.removeAll()
                    self.isDeleteAllTapped = false
                }
            }
    }
}
