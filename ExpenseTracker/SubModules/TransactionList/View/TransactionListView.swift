//
//  TransactionListView.swift
//  ExpenseTracker
//
//  Created by Ali Mert Özhayta on 23.04.2022.
//

import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel

    var body: some View {
        VStack {
            List {
                ForEach(Array(transactionListVM.groupTransactionsByMonth()), id: \.key) { month, transactions in
                    Section {
                        // MARK: Transaction List
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }

                    } header: {
                        // MARK: Transaction Month
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionlistpreviewData
        return transactionListVM
    }()

    static var previews: some View {
        Group {
            NavigationView {
                TransactionListView()
                    .preferredColorScheme(.dark)
            }
            NavigationView {
                TransactionListView()
            }
        }
        .environmentObject(transactionListVM)
    }
}
