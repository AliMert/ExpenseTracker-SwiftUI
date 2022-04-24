//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Ali Mert Özhayta on 16.04.2022.
//

import Combine
import Foundation
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(date: String, value: Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        getTransactions()
    }

    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions:", error.localizedDescription)
                    print("fetching data from mock....")
                    guard let path = Bundle.main.path(forResource: "response", ofType: "json"),
                          let data = NSData(contentsOfFile: path) as Data?,
                          let transactions = try? JSONDecoder().decode([Transaction].self, from: data) else {
                              print("...fetching data from mock is failed")
                              return
                          }
                    print("...fetching data from mock is succeeded")
                    self.transactions = transactions
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] (result) in
                self?.transactions = result
            }
            .store(in: &cancellables)
    }

    func groupTransactionsByMonth() -> TransactionGroup {
        TransactionGroup(grouping: transactions) { $0.month }
    }

    func accumulateTransactions() -> TransactionPrefixSum {
        print("accumulateTransactions")
        // for demo purposes lets accept todays date as "02/17/2022"
        guard !transactions.isEmpty,
              let today = "02/17/2022".parseToDate(),
              let dateInterval = Calendar.current.dateInterval(of: .month, for: today) else {
                  return []
              }
        print("dateInterval", dateInterval)

        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()

        // striding by day: seconds -> minutes -> hour -> day
        for date in stride(from: dateInterval.start, through: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.parsedDate == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }

            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "dailyTotal:", dailyTotal, "sum:", sum)
        }
        return cumulativeSum
    }
}
