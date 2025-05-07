//
//  LoginManager.swift
//  BilgiArenaApp
//
//  Created by Zemfira Asadzade on 07.05.25.
//

import Foundation

protocol LoginManagerUseCase {
        func login(email: String, password: String, completion: @escaping (LoginResponseModel?, String?) -> Void)

}


class LoginManager: LoginManagerUseCase {
    private let manager = NetworkManager()
    
    func login(email: String, password: String, completion: @escaping (LoginResponseModel?, String?) -> Void) {
        let request = LoginRequestModel(email: email, password: password)
        
        do {
            let params = try request.asDictionary()
            manager.request(
                endpoint: "login",
                model: LoginResponseModel.self,
                method: .post,
                params: params,
                encodingType: .json,
                header: ["Content-Type": "application/json"],
                completion: completion
            )
        } catch {
            completion(nil, "Parametrlər çevrilə bilmədi")
        }
        
    }
    
}
