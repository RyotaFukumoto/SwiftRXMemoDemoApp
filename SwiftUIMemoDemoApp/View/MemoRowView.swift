//
//  MemoRowView.swift
//  SwiftUIMemoDemoApp
//
//  Created by ryota on 2021/08/23.
//

import SwiftUI

struct MemoRowView: View {
    var memo: MemoDto

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
