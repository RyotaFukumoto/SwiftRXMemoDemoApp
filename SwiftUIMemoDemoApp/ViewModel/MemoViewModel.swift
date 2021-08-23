//
//  MemoViewModel.swift
//  SwiftUIMemoDemoApp
//
//  Created by ryota on 2021/08/22.
//

import Foundation
import Combine

class MemoViewModel: ObservableObject {

    @Published private(set) var memos: [MemoDataModel] = Array(MemoDataModel.findAll())
    @Published var memoTextField = ""
    @Published var deleteMemo: MemoDataModel?
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
                let memo = MemoDataModel()
                memo.text = text
                self.memos.append(memo)
                MemoDataModel.add(memo)
            }
        deleteMemoTask = self.$deleteMemo
            .sink() { memo in
                guard let memo = memo else {
                    return
                }
                if let index = self.memos.firstIndex(of: memo) {
                    self.memos.remove(at: index)
                    MemoDataModel.delete(memo)
                }
            }
        deleteAllMemoTask = self.$isDeleteAllTapped
            .sink() { isDeleteAllTapped in
                if (isDeleteAllTapped) {
                    MemoDataModel.delete(self.memos)
                    self.memos.removeAll()
                    self.isDeleteAllTapped = false
                }
            }
    }
}
