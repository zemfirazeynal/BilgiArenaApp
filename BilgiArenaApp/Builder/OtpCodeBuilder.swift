//
//  OtpCodeBuilder.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 25.04.25.
//

import Foundation
import UIKit

struct OtpCodeBuilder {
    static func build(email: String, coordinator: SignupFlowCoordinatorProtocol) -> UIViewController {
        let viewModel = OtpCodeViewModel(flowType: .signup, coordinator: coordinator)
        viewModel.email = email
        let controller = OtpCodeViewController(viewModel: viewModel)
        return controller
    }
}
