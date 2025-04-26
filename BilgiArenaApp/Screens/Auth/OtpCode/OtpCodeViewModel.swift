//
//  OtpCodeViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 25.04.25.
//

import Foundation

enum OtpCodeFlowType {
    case signup
    case forgotPassword
}

protocol OtpCodeViewModelProtocol {
    var otpCode: String { get set }
    var onNextStep: (() -> Void)? { get set }
    func proceedIfValid()
}

final class OtpCodeViewModel: OtpCodeViewModelProtocol {
        let flowType: OtpCodeFlowType
        var otpCode: String = ""
        var onNextStep: (() -> Void)?
        
        private  var coordinator: AnyObject

        
        init(flowType: OtpCodeFlowType, coordinator: AnyObject) {
                self.flowType = flowType
            self.coordinator = coordinator

            }


        func proceedIfValid() {
                 guard isValidOtpCode(otpCode) else {
                     print("Invalid otp code")
                     return
                 }
            switch flowType {
                    case .signup:
                        (coordinator as? SignupFlowCoordinatorProtocol)?.showPasswordStep()
                    case .forgotPassword:
                        (coordinator as? ResetPasswordCoordinatorProtocol)?.showNewPasswordScreen()
                    }
          }
        
            private func isValidOtpCode(_ otpCode: String) -> Bool {
                return otpCode.count == 6
            }
}
