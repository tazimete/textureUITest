//
//  Optional+Extensions.swift
//  currency-converter
//
//  Created by AGM Tazim on 5/21/22.
//

import Foundation
import UIKit


extension Optional where Wrapped == String {
    var unwrappedValue: String {
        return self ?? ""
    }
}

extension Optional where Wrapped == Int {
    var unwrappedValue: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == Float {
    var unwrappedValue: Float {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Double {
    var unwrappedValue: Double {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == CGFloat {
    var unwrappedValue: CGFloat {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Bool {
    var unwrappedValue: Bool {
        return self ?? false
    }
}

extension Optional where Wrapped == NSDictionary {
    var unwrappedValue: NSDictionary {
        return self ?? [:]
    }
}
