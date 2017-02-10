//
//  GlobalFunctions.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-20.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation

func execute(after delay: Double, closure: @escaping ()->()) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
        closure()
    })
}
