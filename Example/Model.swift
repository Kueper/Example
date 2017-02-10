//
//  Model.swift
//  LifePath
//
//  Created by Eric Kueper on 2017-02-02.
//  Copyright © 2017 Kueper. All rights reserved.
//

import Foundation

class Object: ObjectProtocol, Equatable {
    
    public static func ==(lhs: Object, rhs: Object) -> Bool {
        return lhs.id == rhs.id && lhs.id != nil && rhs.id != nil
    }
    
    var id: Int?
    
    init() {
        
    }
}

class Task {
    
    var name: String?
    var completed: Bool = false
    
    var subtasks: [Task] = []
    
    init(name: String) {
        
        self.name = name
    }
}

class List {
    
    static let shared = List()
    
    var tasks: [Task] = []
    
    init() {
        
    }
}
