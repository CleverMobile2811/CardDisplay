//
//  SharedVariable.swift
//  CardDisplay
//
//  Created by Ricky on 10/22/20.
//

class SharedVariable {
    static var instance = SharedVariable()
    
    var cardArray: [Card] = []
    var selCard: Card? = nil
    static func shareInstance() -> SharedVariable {
        return instance
    }
    private init() {}
}
