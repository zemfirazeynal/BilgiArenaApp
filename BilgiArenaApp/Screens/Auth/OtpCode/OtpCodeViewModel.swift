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
    func proceedIfValid()}

//final class OtpCodeViewModel: OtpCodeViewModelProtocol {
//    var otpCode: String = ""
//    var onNextStep: (() -> Void)?
//
//     func proceedIfValid() {
//         guard isValidOtpCode(otpCode) else {
//             print("Invalid otp code")
//             return
//         }
//         onNextStep?()
//  }
//
//    private func isValidOtpCode(_ otpCode: String) -> Bool {
//        return otpCode.contains("1111")
//    }
//}


final class OtpCodeViewModel: OtpCodeViewModelProtocol {
    let flowType: OtpCodeFlowType
    var otpCode: String = ""
    var onNextStep: (() -> Void)?
    
    init(flowType: OtpCodeFlowType) {
            self.flowType = flowType
        }


    func proceedIfValid() {
             guard isValidOtpCode(otpCode) else {
                 print("Invalid otp code")
                 return
             }
             onNextStep?()
      }
    
        private func isValidOtpCode(_ otpCode: String) -> Bool {
            return otpCode.count == 6
        }
}
