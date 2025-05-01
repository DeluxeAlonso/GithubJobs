//
//  View+UIFont.swift
//  GithubJobs
//
//  Created by Alonso on 30/04/25.
//

import SwiftUI

extension View {

    /// Applies a UIFont to a SwiftUI view
    func uiFont(_ font: UIFont) -> some View {
        self.font(Font(font))
    }

}
