//
//  MockManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 16.07.25.
//

protocol MockManagerUseCase {
    func mockSendOtp(completion: @escaping (Bool, String?) -> Void)
    func mockVerifyOtp(completion: @escaping (String?, String?) -> Void)
    func mockResetPassword(completion: @escaping (Bool, String?) -> Void)
}


final class MockManager: MockManagerUseCase {
    var shouldSucceed = true
    var mockJWT: String = "mock.jwt.token"

    func mockSendOtp(completion: @escaping (Bool, String?) -> Void) {
        if shouldSucceed {
            completion(true, nil)
        } else {
            completion(false, "OTP göndərmə xətası")
        }
    }

    func mockVerifyOtp(completion: @escaping (String?, String?) -> Void) {
        if shouldSucceed {
            completion(mockJWT, nil)
        } else {
            completion(nil, "OTP yoxlanışı zamanı xəta baş verdi")
        }
    }

    func mockResetPassword(completion: @escaping (Bool, String?) -> Void) {
        if shouldSucceed {
            completion(true, nil)
        } else {
            completion(false, "Şifrə yenilənmədi")
        }
    }
}
