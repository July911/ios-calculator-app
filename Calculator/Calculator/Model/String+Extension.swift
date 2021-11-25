import Foundation

extension String {
    func split(with target: Character) -> [String] {
        let splitedString = self.split(separator: target).map { String($0) }
        return splitedString
    }
}

extension String {
    func hasComma() -> Bool {
        self.contains(".")
    }
    
    func insertComma() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .halfUp
        
        let splitByDecimalPoint = self.split(with: ".")
        guard let doubleTypeInteger = Double(splitByDecimalPoint[0]) else {
            return ""
        }
        guard let integerWithComma = numberFormatter.string(from: NSNumber(value: doubleTypeInteger)) else {
            return ""
        }
        
        let valueWithComma: String
        if self.last == "." {
            valueWithComma = integerWithComma + "."
        } else if self.contains(".") && splitByDecimalPoint.count == 2 {
            let decimalValue = splitByDecimalPoint[1]
            valueWithComma = integerWithComma + "." + decimalValue
        } else {
            valueWithComma = integerWithComma
        }
        return valueWithComma
    }
}

extension Array {
    func hasComma() -> Bool{
        (self.filter{ ($0 as? String) == "." }).count == 0 ? false : true
    }
}



