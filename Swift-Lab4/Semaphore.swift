import Foundation

var accountBalance = 1000
let balanceAccessSemaphore = DispatchSemaphore(value: 1)

func withdraw(amount: Int) {
    DispatchQueue.global().async {
        // Використовуємо семафор для захисту від гонки за даними
        balanceAccessSemaphore.wait()
        defer { balanceAccessSemaphore.signal() }
        
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
    DispatchQueue.global().async {
        // Використовуємо семафор для захисту від гонки за даними
        balanceAccessSemaphore.wait()
        defer { balanceAccessSemaphore.signal() }
        
        Thread.sleep(forTimeInterval: 1)
        accountBalance += amount
        print("Refill successful. Remaining balance: \(accountBalance)")
    }
}

for _ in 1...5 {
    withdraw(amount: 150)
    refillBalance(amount: 200)
}


// Sleep to allow asynchronous operations to complete
Thread.sleep(forTimeInterval: 6)