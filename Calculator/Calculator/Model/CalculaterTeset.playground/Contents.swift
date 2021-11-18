import UIKit

enum csese: Int, CaseIterable {
    case a = 1
    case b = 2
    case c = 3
    case d = 4
    
    var dd: String {
        return String(self)
    }
}

let kk = "a"
let a = csese.allCases.map{ $0.rawValue }
let b = csese.allCases
let c = csese.allCases.compactMap{ ($0) }
print(type(of: b))
print(type(of: c))

print(csese.a.dd)



