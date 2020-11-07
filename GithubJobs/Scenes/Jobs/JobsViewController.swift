//
//  JobsViewController.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class JobsViewController: UIViewController {

    private var jobsView: JobsView!

    // MARK: - Lifecycle

    override func loadView() {
        jobsView = JobsView()
        self.view = jobsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
