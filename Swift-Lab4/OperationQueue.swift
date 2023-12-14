import Foundation

let concurrentQueue = OperationQueue()
var accountBalance = 1000
let balanceAccessQueue = DispatchQueue(label: "com.example.balanceAccessQueue")

func withdraw(amount: Int) {
    concurrentQueue.addOperation {
        // Використовуємо замок для захисту від гонки за даними
        balanceAccessQueue.sync {
            if accountBalance >= amount {
                Thread.sleep(forTimeInterval: 1)
                accountBalance -= amount
                print("Withdrawal successful. Remaining balance: \(accountBalance)")
            } else {
                print("Insufficient funds")
            }
        }
    }
}

func refillBalance(amount: Int) {
    concurrentQueue.addOperation {
        // Використовуємо замок для захисту від гонки за даними
        balanceAccessQueue.sync {
            Thread.sleep(forTimeInterval: 1)
            accountBalance += amount
            print("Refill successful. Remaining balance: \(accountBalance)")
        }
    }
}

for _ in 1...5 {
    withdraw(amount: 150)
    refillBalance(amount: 200)
}

// Sleep to allow asynchronous operations to complete
Thread.sleep(forTimeInterval: 6)