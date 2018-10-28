//
//  String.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import Foundation

extension String {

    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    /// format value as 100 000.00
    var formattedGroupingValue: String {
        let numFormatter = NumberFormatter()
        numFormatter.usesGroupingSeparator = true
        numFormatter.numberStyle = .decimal
        if isContainsDecimalSeparator {
            let separator = self.contains(numFormatter.decimalSeparator) ? numFormatter.decimalSeparator : "."
            numFormatter.decimalSeparator = separator
        }
        numFormatter.groupingSeparator = " "

        let splitted = self.components(separatedBy: numFormatter.decimalSeparator)

        var integer = splitted.first?.digits ?? ""
        let fraction = splitted.last?.digits ?? ""

        // format only integer part of value
        integer = numFormatter.string(from: NSNumber(value: integer.doubleValue)) ?? ""

        return integer + (splitted.count == 2 ? numFormatter.decimalSeparator + fraction : "")
    }

    var isContainsDecimalSeparator: Bool {
        let dotSeparator = "."
        let comaSeparator = ","
        if self.contains(dotSeparator) {
            return true
        } else if self.contains(comaSeparator) {
            return true
        }
        return false
    }

    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }

    var doubleValue: Double {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        if let result = nf.number(from: self) {
            return result.doubleValue
        } else {
            nf.decimalSeparator = ","
            if let result = nf.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }

}
