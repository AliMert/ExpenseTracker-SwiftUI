//
//  RecentTransactionListView.swift
//  ExpenseTracker
//
//  Created by Ali Mert Özhayta on 23.04.2022.
//

import SwiftUI

struct RecentTransactionListView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel

    var body: some View {
        VStack {
            HStack {
                // MARK: Header Title
                Text("Recent Transactions").bold()

                Spacer()

                // MARK: Header Link
                NavigationLink {
                    TransactionListView()
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)

            // MARK: Recent Transaction List
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id: \.element) { (index, transaction) in
                TransactionRow(transaction: transaction)

                if index != 4 {
                    Divider()
                }
            }

        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionListView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionlistpreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group {
            RecentTransactionListView()
                .preferredColorScheme(.dark)
            RecentTransactionListView()
        }
        .environmentObject(transactionListVM)
    }
}
