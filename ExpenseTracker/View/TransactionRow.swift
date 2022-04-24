//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Ali Mert Özhayta on 16.04.2022.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transaction: Transaction

    var body: some View {
        HStack(spacing: 20) {
            // MARK: Transaction Category Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(
                        .awesome5Solid(code: transaction.icon),
                        fontsize: 24,
                        color: Color.icon
                    )
                }

            VStack(alignment: .leading, spacing: 6) {
                // MARK: Transaction Merchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)

                // MARK: Transaction Category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)

                // MARK: Transaction Date
                Text(transaction.parsedDate, format: .dateTime.day().year().month())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }

            Spacer()

            // MARK: Transaction Amount
            Text(transaction.amount, format: .currency(code: "TRY"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
        }
        .padding([.top, .bottom], 8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transaction: transactionPreviewData)
            .preferredColorScheme(.dark)
        TransactionRow(transaction: transactionPreviewData)
    }
}
