struct SignupPasswordBuilder {
    static func build(coordinator: SignupFlowCoordinatorProtocol) -> UIViewController {
        let viewModel = SignupPasswordViewModel(coordinator: coordinator)
        let viewController = SignupPasswordViewController(viewModel: viewModel)
        return viewController
    }
}
