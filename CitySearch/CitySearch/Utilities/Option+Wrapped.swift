//
//  Option+Wrapped.swift
//  CitySearch
//
//  Created by Dhananjay Kumar Dubey on 1/8/21.
//

import Foundation

extension Optional where Wrapped == String {
    func replaceCharacter(in range: NSRange, replacementString string: String) -> String {
        guard let text = self, let textRange = Range(range, in: text) else { return "" }
        return text.replacingCharacters(in: textRange, with: string).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
