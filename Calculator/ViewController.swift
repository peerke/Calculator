//
//  ViewController.swift
//  Calculator
//
//  Created by Peter Fortuin on 11/03/15.
//  Copyright (c) 2015 Peter Fortuin. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var dotInNumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
            dotInNumber = false
        }
        println("digit = \(digit)")
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        switch operation {
        case "×": performOperation() {$1 * $0}
        case "÷": performOperation() {$1 / $0}
        case "−": performOperation() {$1 - $0}
        case "+": performOperation() {$1 + $0}
        case "√": performOperation() {sqrt($0)}
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: (Double) -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    @IBAction func dot() {
        if (!dotInNumber) {
            display.text = display.text! + "."
            userIsInTheMiddleOfTypingANumber = true
            dotInNumber = true
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
            dotInNumber = true
        }
    }
}

