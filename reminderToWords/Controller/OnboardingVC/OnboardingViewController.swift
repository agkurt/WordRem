//
//  OnboardingViewController.swift
//  reminderToWords
//
//  Created by Ahmet Göktürk Kurt on 24.10.2023.
//

import UIKit
import UIOnboarding

class OnboardingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presentOnboarding()
    }
            
    @objc private func presentOnboarding() {
        let onboardingController: UIOnboardingViewController = .init(withConfiguration: .setUp())
        onboardingController.delegate = self
        navigationController?.present(onboardingController, animated: false)
    }
}

extension OnboardingViewController: UIOnboardingViewControllerDelegate {
    func didFinishOnboarding(onboardingViewController: UIOnboardingViewController) {
        onboardingViewController.modalTransitionStyle = .crossDissolve
        onboardingViewController.dismiss(animated: true, completion: nil)
    }
}

extension OnboardingViewController {
    public func setUp() {
        let vc = HomePageController()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .init(named: "camou")
        navigationController?.pushViewController(vc, animated: true)
    }
}
