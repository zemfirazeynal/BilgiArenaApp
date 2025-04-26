//
//  OtpCodeViewModel.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 25.04.25.
//

import Foundation

enum OtpFlowType {
    case signup
    case resetPassword
}

protocol OtpCodeViewModelProtocol {
    var otpCode: String { get set }
    var onNextStep: (() -> Void)? { get set }
    func proceedIfValid()}

final class OtpCodeViewModel: OtpCodeViewModelProtocol {
    var otpCode: String = ""
    var onNextStep: (() -> Void)?
    
//    let email: String
//        let flowType: OtpFlowType
//
//        init(email: String, flowType: OtpFlowType) {
//            self.email = email
//            self.flowType = flowType
//        }
//
//        var shouldShowProgress: Bool {
//            return flowType == .signup
//        }
//    
    

     func proceedIfValid() {
         guard isValidOtpCode(otpCode) else {
             print("Invalid otp code")
             return
         }
         onNextStep?()
  }

    private func isValidOtpCode(_ otpCode: String) -> Bool {
        return otpCode.contains("1111")
    }
}
