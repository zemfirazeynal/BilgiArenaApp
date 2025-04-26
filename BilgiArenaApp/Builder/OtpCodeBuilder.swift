//
//  OtpCodeBuilder.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 25.04.25.
//

import Foundation
import UIKit

struct OtpCodeBuilder {
    static func build(coordinator: SignupFlowCoordinatorProtocol) -> UIViewController {
        let viewModel = OtpCodeViewModel(flowType: .signup, coordinator: coordinator)
            let viewController = OtpCodeViewController(viewModel: viewModel)
            return viewController
        }
}
