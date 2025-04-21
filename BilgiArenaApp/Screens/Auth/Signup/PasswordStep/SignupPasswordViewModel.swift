final class SignupPasswordViewModel: SignupPasswordViewModelProtocol {
    var password: String = ""
    var onFinishSignup: (() -> Void)?

    func proceedIfValid() {
        guard isValidPassword(password) else {
            print("Invalid password")
            return
        }
        onFinishSignup?()
    }

    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6 // sadə şərt: min 6 simvol
    }
}