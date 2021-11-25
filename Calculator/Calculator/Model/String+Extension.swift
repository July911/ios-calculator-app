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
}

extension Array {
    func hasComma() -> Bool{
        (self.filter{ ($0 as? String) == "." }).count == 0 ? false : true
    }
}



