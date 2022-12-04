abstract class CreateWalletState {
  const CreateWalletState();
}

class CreateWalletInitialState extends CreateWalletState {}

class CreateWalletOkState extends CreateWalletState {}

class CreateWalletFailureState extends CreateWalletState {
  final String message;

  const CreateWalletFailureState([this.message = ""]);
}
