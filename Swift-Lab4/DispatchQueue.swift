import Foundation

let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
var accountBalance = 1000

func withdraw(amount: Int) {
  concurrentQueue.async {
    if accountBalance >= amount {
      Thread.sleep(forTimeInterval: 1)
      accountBalance -= amount
      print("Withdrawal successful. Remaining balance: \(accountBalance)")
    } else {
      print("Insufficient funds")
    }
  }
}

func refillBalance(amount: Int) {
  concurrentQueue.async {
    Thread.sleep(forTimeInterval: 1)
    accountBalance += amount
    print("Refill successful. Remaining balance: \(accountBalance)")
  }
}

// Dispatch multiple withdrawals and refills
for _ in 1...5 {
  withdraw(amount: 150)
  refillBalance(amount: 200)
}

// Sleep to allow asynchronous operations to complete
Thread.sleep(forTimeInterval: 6)
