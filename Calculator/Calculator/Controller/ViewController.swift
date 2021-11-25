import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        temporaryOperandValues = [initialValue]
        currentValueLabel.text = initialValue
    }
    
    private func addToFormulaHistory() {
        let stackView = UIStackView()
        stackView.spacing = 8.0
        stackView.axis = .horizontal
        
        let operatorView = UILabel()
        operatorView.text = currentOperatorLabel.text
        operatorView.textColor = .white
        
        let operandView = UILabel()
        operandView.text = currentValueLabel.text
        operandView.textColor = .white
        
        stackView.addArrangedSubview(operatorView)
        stackView.addArrangedSubview(operandView)
        
        formulaStackView.addArrangedSubview(stackView)
    }
    
    private func removeStackViewContents() {
        formulaStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    @IBAction private func hitOperandButton(_ sender: UIButton) {
        guard let inputButtonTitle = sender.titleLabel?.text else {
            return
        }
        guard temporaryOperandValues.count <= 20 else {
            return
        }
        
        if temporaryOperandValues.contains(".") {
            guard inputButtonTitle != "." else {
                return
            }
        } else {
            guard inputButtonTitle != "0" || temporaryOperandValues.first != "0" else {
                return
            }
            guard inputButtonTitle != "00" || temporaryOperandValues.first != "0" else {
                return
            }
        }
        temporaryOperandValues.append(inputButtonTitle)
        
        if !temporaryOperandValues.contains(".") && temporaryOperandValues.first == initialValue {
            temporaryOperandValues.removeFirst()
        }
        
        let addcommaOperand: String
        if temporaryOperandValues.contains(".") {
            addcommaOperand = temporaryOperandValues.joined()
        } else {
            addcommaOperand = addCommaToValue(Double(temporaryOperandValues.joined()) ?? 0)
        }
        
        if signIsPositive {
            currentValueLabel.text = addcommaOperand
        } else {
            currentValueLabel.text = "-" + addcommaOperand
        }
        isOperatorEntered = false
    }
    
    private func endOperandInput() {
        if signIsPositive {
            valuesForCalculate.append(temporaryOperandValues.joined())
        } else {
            valuesForCalculate.append("-" + temporaryOperandValues.joined())
        }
        
        if valuesForCalculate != [initialValue] {
            addToFormulaHistory()
            formulaScrollView.scrollViewToBottom()
        }
        
        temporaryOperandValues = [initialValue]
        currentValueLabel.text = initialValue
        isCalculated = false
        signIsPositive = true
    }
    
    @IBAction private func hitOperatorButton(_ sender: UIButton) {
        guard let inputButtonTitle = sender.titleLabel?.text else {
            return
        }
        endOperandInput()
        resetTemporaryOerandValues()
        if isOperatorEntered {
            valuesForCalculate.removeLast()
            valuesForCalculate.append(inputButtonTitle)
        } else {
            valuesForCalculate.append(inputButtonTitle)
            isOperatorEntered = true
        }
        currentOperatorLabel.text = inputButtonTitle
    }
    
    func resetToInitialState() {
        resetTemporaryOerandValues()
        valuesForCalculate.removeAll()
        isCalculated = false
        currentOperatorLabel.text = ""
    }
    
    func resetTemporaryOerandValues() {
        temporaryOperandValues = [initialValue]
        currentValueLabel.text = initialValue
    }
    
    @IBAction private func hitACButton(_ sender: UIButton) {
        resetToInitialState()
        removeStackViewContents()
        currentValueLabel.text = initialValue
    }
    
    @IBAction private func hitCEButton(_ sender: UIButton) {
        resetTemporaryOerandValues()
        currentValueLabel.text = initialValue
    }
    
    @IBAction private func hitCodeConversionButton(_ sender: UIButton) {
        guard currentValueLabel.text != initialValue else {
            return
        }
        guard let currentOperand = currentValueLabel.text,
              let doubleTypeOperand = Double(currentOperand) else {
                  return
              }
        signIsPositive = !signIsPositive
        currentValueLabel.text = String(format: "%.4g", doubleTypeOperand * -1)
    }

    
    @IBAction private func hitEqualButton(_ sender: UIButton) {
        guard isCalculated == false,
              valuesForCalculate != [initialValue] else {
                  resetTemporaryOerandValues()
              return
        }
        endOperandInput()
        let calculator = ExpressionParser.self
        let doubleTypeResult = calculator.parse(from: valuesForCalculate.joined()).result()
        if doubleTypeResult.isNaN {
            resetToInitialState()
            currentValueLabel.text = "NaN"
        } else {
            resetToInitialState()
            currentValueLabel.text = addCommaToValue(doubleTypeResult)
        }
        isCalculated = true
    }
    
    private func addCommaToValue(_ value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let resultWithComma = numberFormatter.string(for: value) else {
            return "0"
        }
        return resultWithComma
    }
}


}

