//
//  StringExtension.swift
//  QuizZap
//
//  Created by Tales Conrado on 09/02/21.
//

import Foundation

extension String {
    /// Converts HTML string to a `NSAttributedString`
    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}
