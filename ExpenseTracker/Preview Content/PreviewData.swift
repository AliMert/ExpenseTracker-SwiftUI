//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Ali Mert Özhayta on 16.04.2022.
//

var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "Desjardins", account: "Visa Desjardins", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category:"Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionlistpreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
