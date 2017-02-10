//
//  Constant.swift
//  Placeholder
//
//  Created by Eric Kueper on 2016-10-12.
//  Copyright © 2016 Softprint. All rights reserved.
//

import Foundation

struct Constant {
        
    #if DEBUG
    static let url = "http://hizentra.dogsyncapp.com/api"           // Staging Server
    #else
    static let url = ""
    #endif
    
    static let DIN = "02370352"
    
    static let reachability = Reachability.init()
    
    enum Language {
        case English
        
        var name: String {
            switch self {
            case .English:
                return "English"
            }
        }
    }
    
    static var language: Language = .English
}

struct Platform {
    
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

