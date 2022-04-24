//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Ali Mert Özhayta on 16.04.2022.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()

                    // MARK: Chart
                    let data = transactionListVM.accumulateTransactions()
                    let totalExpenses = data.last?.value ?? 0
                    if !data.isEmpty {
                        CardView {
                            VStack(alignment: .leading) {
                                ChartLabel(
                                    totalExpenses.formatted(.currency(code: "TRY")),
                                    type: .title,
                                    format: "\(Locale(identifier: "tr_TR").currencySymbol ?? "")%.02f"
                                )
                                LineChart()
                            }
                            .background(Color.systemBackground)
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height: 200)
                    }

                    // MARK: Transaction List
                    RecentTransactionListView()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Notification Icon
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .renderingMode(.original)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionlistpreviewData
        return transactionListVM
    }()

    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
        }
        .environmentObject(transactionListVM)
    }
}
