//
//  String+HTML.swift
//  GithubJobs
//
//  Created by Alonso on 11/8/20.
//

import Foundation

extension String {

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let attributedStringOptions: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue
            ]
            return try NSAttributedString(data: data,
                                          options: attributedStringOptions,
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string.trailingNewLinesTrimmed ?? ""
    }

    var trailingNewLinesTrimmed: String {
        var newString = self

        while newString.last?.isNewline == true {
            newString = String(newString.dropLast())
        }

        return newString
    }

}
