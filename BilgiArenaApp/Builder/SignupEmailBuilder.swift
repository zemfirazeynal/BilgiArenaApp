final class SignupEmailBuilder {
    static func build(coordinator: SignupFlowCoordinatorProtocol) -> UIViewController {
        let viewModel = SignupEmailViewModel()
        let vc = SignupEmailViewController(viewModel: viewModel)

        viewModel.onNextStep = {
            coordinator.showPasswordStep()
        }

        return vc
    }
}