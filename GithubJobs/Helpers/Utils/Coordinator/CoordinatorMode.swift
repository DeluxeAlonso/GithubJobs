//
//  CoordinatorMode.swift
//  GithubJobs
//
//  Created by Alonso on 18/02/25.
//

import UIKit

enum CoordinatorMode {

    case push
    case present(presentingViewController: UIViewController, configuration: CoordinatorModePresentConfiguration?)
    case embed(parentViewController: UIViewController, containerView: UIView?)

}
