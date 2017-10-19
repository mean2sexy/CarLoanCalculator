//
//  Car.swift
//  CarLoanCalculator
//
//  Created by Chaturon Itthiprapakul on 9/27/17.
//  Copyright © 2017 Toyota Lampang. All rights reserved.
//

import Foundation

class Car{
    var carPrice : Double
    var downPaymentAmount : Double
    
    var financingAmount : Double = 0
    var paymentPerMonth : Double = 0
    
    var interestRate : Double
    var installment : Int //งวดชำระ
    
    var rv : Double = 0
    
    init(){
        self.carPrice = 0
        self.downPaymentAmount = 0
        
        self.interestRate = 0
        self.installment = 0
    }
    
    init(carPrice: Double,downPaymentAmount: Double,interestRate: Double,installment: Int){
        self.carPrice = carPrice
        self.downPaymentAmount = downPaymentAmount
        self.interestRate = interestRate
        self.installment = installment
    }
    
    func calculateFinancingAmount() {
        financingAmount = carPrice - downPaymentAmount
    }
    
    func calculatePaymentPerMonth() {
        
        calculateFinancingAmount()
        print("Installment = \(installment)")
        
        paymentPerMonth = (financingAmount + (financingAmount * (interestRate/100) * Double(installment)))/Double(installment * 12)
    }
    
    func calculateSabuyDPaymentPerMonth(){
        
        calculateFinancingAmount()
        
        let rvPercentage = self.rv
        let rvAmount = (carPrice * rvPercentage/100)
        
        print("RV = \(rvAmount)")
        print("Installment = \(installment)")
        
        paymentPerMonth = ((financingAmount + (financingAmount * (interestRate/100) * Double(installment))) - rvAmount)/(Double(installment * 12)-1)
    }
    
}
