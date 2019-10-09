
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var UserIsInTheMiddleOfTypingANumber = false
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        if UserIsInTheMiddleOfTypingANumber {
            if(display.text!.rangeOfString(".")?.startIndex == nil || digit != "."){
                     display.text = display.text! + digit
            }
        }else{
            display.text = digit
            UserIsInTheMiddleOfTypingANumber = true
            
        }
    }

    @IBAction func operate(sender: UIButton) {
        
        if UserIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            }else{
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        UserIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
        
    }
    
    var displayValue: Double {
        get{
        return  NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
        display.text = "\(newValue)"
        UserIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

