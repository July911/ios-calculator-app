import Foundation

class Node<Element> {
    let nodeValue: Element
    var pointer: Node?
    
    init(nodeValue: Element, pointer: Node? = nil) {
        self.nodeValue = nodeValue
        self.pointer = pointer
    }
}
