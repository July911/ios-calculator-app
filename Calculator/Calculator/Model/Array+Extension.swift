import Foundation

extension Array {
    func hasComma() -> Bool{
        (self.filter{ ($0 as? String) == "." }).count == 0 ? false : true
    }
}

