//
//  NSobject+Extensions.swift
//  BabckBaseTest
//
//  Created by Lakshminaidu on 10/7/21.
//

import Foundation

//MARK: NSObject
extension NSObject {
    
    var name: String {
        return String(describing: type(of: self))
    }
    
    static var name: String {
        return String(describing: self)
    }
}
