
import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var temperaryLabel: String = ""
    var isOperated: Bool = false
    
    @IBAction func touchUpNumberButton( sender: UIButton) throws {
        
        guard let clikedNumber = sender.titleLabel?.text else {
            throw QueueError.EmptyInLinkedList
        }
        temperaryLabel += clikedNumber
    }
    
    @IBAction func touchUpOperatorButton( sender: UIButton) throws {
        guard let clikedOperator = sender.titleLabel?.text else {
            throw QueueError.EmptyInLinkedList
        }
        temperaryLabel += clikedOperator
        isOperated = true 
    }
}
