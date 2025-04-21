final class SignupEmailViewModel {
    var email: String = ""

    var onNextStep: (() -> Void)?

    func proceedIfValid() {
        guard isValidEmail(email) else { return }
        onNextStep?()
    }

    private func isValidEmail(_ email: String) -> Bool {
        // Sadə regex yoxlaması
        return email.contains("@") && email.contains(".")
    }
}