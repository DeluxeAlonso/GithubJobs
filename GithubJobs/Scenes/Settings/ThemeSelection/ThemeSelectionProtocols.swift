//
//  ThemeSelectionProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import Combine

protocol ThemeSelectionViewModelProtocol {

    var didSelectTheme: PassthroughSubject<Void, Never> { get }

    var themes: [ThemeSelectionItemModel] { get }

    func screenTitle() -> String?
    func headerTitle(for section: Int) -> String?

    func selectTheme(at index: Int)

}

protocol ThemeSelectionCoordinatorProtocol: AnyObject {
    func dismiss()
}
