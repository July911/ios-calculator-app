
import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var currentNumber: UILabel!
    @IBOutlet weak var currentOperator: UILabel!
    
    
    var temperaryLabel: String = ""
    var needOperator: Bool = false
    
    @IBAction func touchUpNumberButton( sender: UIButton) throws {
        needOperator = true
        
        guard let clikedNumber = sender.titleLabel?.text else {
            throw QueueError.EmptyInLinkedList
        }
        currentNumber.text! += clikedNumber
    }
    
    @IBAction func touchUpOperatorButton( sender: UIButton) throws {
        guard let clikedOperator = sender.titleLabel?.text else {
            throw QueueError.EmptyInLinkedList
        }
        
        if !needOperator {
            currentOperator.text = clikedOperator
        }
        
        if needOperator {
            cleanUpLabelText()
        }
        
        temperaryLabel.append(clikedOperator)
        currentOperator.text = clikedOperator
    }
    
    func cleanUpLabelText() {
        guard let onboardingNumber = currentNumber.text else {
            return
        }
        
        temperaryLabel += onboardingNumber
        currentNumber.text = 0.description
        
    }
    
    @IBAction func touchUpCEbutton(_ sender: UIButton) {
        if needOperator {
            cleanUpLabelText()
        }
        
    }
}


