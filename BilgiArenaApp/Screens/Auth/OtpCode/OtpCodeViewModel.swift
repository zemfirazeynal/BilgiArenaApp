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
    var email: String { get set }
    var onNextStep: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    
    func proceedIfValid()
}

final class OtpCodeViewModel: OtpCodeViewModelProtocol {
    let flowType: OtpCodeFlowType
    var otpCode: String = ""
    var email: String = ""
    var onNextStep: (() -> Void)?
    var onError: ((String) -> Void)?

    private var coordinator: AnyObject
    private let registerManager: RegisterManagerUseCase
    
    var onStateChange: ((ViewState) -> Void)?


    private var jwtToken: String?

    init(flowType: OtpCodeFlowType,
         coordinator: AnyObject,
         registerManager: RegisterManagerUseCase = RegisterManager()
    ) {
        self.flowType = flowType
        self.coordinator = coordinator
        self.registerManager = registerManager
    }

    func proceedIfValid() {
               guard isValidOtpCode(otpCode) else {
                    onStateChange?(.error(message: "OTP code must be 6 digits long."))
                    return
                }

                onStateChange?(.loading)

                registerManager.verifyOtp(email: email, otp: otpCode) { [weak self] token, error in
                    guard let self else { return }

                    if let token = token, !token.isEmpty {
                        switch self.flowType {
                        case .signup:
                            (self.coordinator as? SignupFlowCoordinatorProtocol)?.showPasswordStep(token: token)
                        case .forgotPassword:
                            (self.coordinator as? ResetPasswordCoordinatorProtocol)?.showNewPasswordScreen()
                        }
                    } else {
                        onStateChange?(.error(message: "OTP Code is wrong. Please try again."))
                    }
                }
        
    }

    private func isValidOtpCode(_ otpCode: String) -> Bool {
        return otpCode.trimmingCharacters(in: .whitespacesAndNewlines).count == 6
    }
}
//    var otpCode: String { get set }
//    var onNextStep: (() -> Void)? { get set }
//    func proceedIfValid()
//    
//
//}
//
//final class OtpCodeViewModel: OtpCodeViewModelProtocol {
//        let flowType: OtpCodeFlowType
//        var otpCode: String = ""
//        var onNextStep: (() -> Void)?
//        
//       var email: String = ""
//
//        private  var coordinator: AnyObject
//
//        
//        init(flowType: OtpCodeFlowType, coordinator: AnyObject) {
//                self.flowType = flowType
//            self.coordinator = coordinator
//
//            }
//
//
//        func proceedIfValid() {
//                 guard isValidOtpCode(otpCode) else {
//                     print("Invalid otp code")
//                     return
//                 }
//            switch flowType {
//                    case .signup:
//                        (coordinator as? SignupFlowCoordinatorProtocol)?.showPasswordStep()
//                    case .forgotPassword:
//                        (coordinator as? ResetPasswordCoordinatorProtocol)?.showNewPasswordScreen()
//                    }
//          }
//        
//            private func isValidOtpCode(_ otpCode: String) -> Bool {
//                return otpCode.count == 6
//            }
//}
