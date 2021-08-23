//
//  MemoListView.swift
//  SwiftUIMemoDemoApp
//
//  Created by ryota on 2021/08/22.
//

import SwiftUI

// MARK: MemoListView
struct MemoListView: View {
    @ObservedObject var viewModel = MemoViewModel()

    @State private var isMemoTextFieldPresented = false
    @State private var isDeleteAlertPresented = false
    @State private var isDeleteAllAlertPresented = false
    @State private var memoTextField = ""

    var body: some View {
        NavigationView {
            VStack {
                if (isMemoTextFieldPresented) {
                    TextField("メモを入力してください", text: $memoTextField)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .keyboardType(.asciiCapable)
                }
                List {
                    ForEach(viewModel.memos.sorted {
                        $0.postedDate > $1.postedDate
                    }) { memo in
                        HStack {
                            MemoRowView(memo: memo)
                            Spacer()
                        }
                        .alert(isPresented: $isDeleteAlertPresented) {
                            Alert(title: Text("警告"),
                                  message: Text("メモを削除します。\nよろしいですか？"),
                                  primaryButton: .cancel(Text("いいえ")),
                                  secondaryButton: .destructive(Text("はい")) {
                                    viewModel.deleteMemo = memo
                                  }
                            )
                        }
                    }.onDelete{ indexSet in
                        if let index = indexSet.first {
                            viewModel.deleteMemo = viewModel.memos[(index)]
                        }
                      }
                }
            }
            .navigationTitle("メモの一覧")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("全削除") {
                        isDeleteAllAlertPresented.toggle()
                    }
                    .disabled(viewModel.memos.isEmpty)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("追加") {
                        if (isMemoTextFieldPresented) {
                            viewModel.memoTextField = memoTextField
                            memoTextField = ""
                        }
                        isMemoTextFieldPresented.toggle()
                    }.disabled(isMemoTextFieldPresented && memoTextField.isEmpty)
                }
            }
            .alert(isPresented: $isDeleteAllAlertPresented) {
                Alert(title: Text("警告"),
                      message: Text("全てのメモを削除します。\nよろしいですか？"),
                      primaryButton: .cancel(Text("いいえ")),
                      secondaryButton: .destructive(Text("はい")) {
                        viewModel.isDeleteAllTapped = true
                      }
                )
            }
        }
    }
}

// MARK: MemoRowView
struct MemoRowView: View {
    var memo: MemoDataModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(formatDate(memo.postedDate))
                .font(.caption)
                .fontWeight(.bold)
            Text(verbatim: memo.text)
                .font(.body)
        }
    }

    func formatDate(_ date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
    }
}
