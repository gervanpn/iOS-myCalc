//  Calculator Project
//
//  Created by Gervan Nantel

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var resultLabel: UILabel!
    
    var currentNumber: Double = 0
    var previousNumber: Double = 0
    var operation = 0
    var isPerfOp = true
    var negative = false
    var preNeg = ""
    var point = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultLabel.text = "0"
    }

    @IBAction func numberPress(_ sender: Any) {
        
        guard let tag = (sender as? UIButton)?.tag else { return }
        
        if isPerfOp == true {
            isPerfOp = false
            resultLabel.text = String(tag-1)
        } else if let newText = resultLabel.text {
             resultLabel.text = newText + String(tag - 1)
            }
        if let resultText = resultLabel.text, let curNum = Double(resultText) {
            currentNumber = curNum
        }
    }
    
    @IBAction func operatorPress(_ sender: Any) {
        let tag = (sender as! UIButton).tag
        
        /* decimal */
        if tag == 17 && point == false {
            point = true
            isPerfOp = false
            resultLabel.text = resultLabel.text! + "."
        } else {
            resultLabel.text = resultLabel.text!
            isPerfOp = false
        }
        
        /* clear button - 16 */
        if tag == 16 {
            resultLabel.text = "0"
            preNeg = ""
            previousNumber = 0
            currentNumber = 0
            operation = 0
            isPerfOp = true  /* reset the booleans back to origianl state */
            point = false
            negative = false
            return
        }
        
        if (tag == 11 || tag == 12 || tag == 13 || tag == 14) {
            operation = tag
            isPerfOp = true
            point = false
            previousNumber = Double(resultLabel.text!)!
            
            if tag == 11 {
                resultLabel.text = "÷"
            } else if tag == 12 {
                resultLabel.text = "×"
            } else if tag == 13 {
                resultLabel.text = "-"
            } else if tag == 14 {
                resultLabel.text = "+"
            }
        }
        
        if tag == 15{
            isPerfOp = true
            if operation == 11 {
                resultLabel.text = String(previousNumber / currentNumber)
            } else if operation == 12 {
                resultLabel.text = String(previousNumber * currentNumber)
            } else if operation == 13 {
                resultLabel.text = String(previousNumber - currentNumber)
            } else if operation == 14 {
                resultLabel.text = String(previousNumber + currentNumber)
            }
        }
        
        /* negative value set & reset */
        if tag == 18 && negative == false {
            negative = true
            isPerfOp = false
            preNeg = resultLabel.text!
            resultLabel.text = "-" + resultLabel.text!
        } else if tag == 18 && negative == true {
            negative = false
            isPerfOp = false
            resultLabel.text = preNeg
        } else {
            resultLabel.text = resultLabel.text
        }
        
        /* percentage converter */
        if tag == 19 {
            isPerfOp = false
            let percent = Double(resultLabel.text!)!
            let newValue = percent / 100
            currentNumber = newValue
            resultLabel.text! = String(newValue)
        }
    }
    
    
}

