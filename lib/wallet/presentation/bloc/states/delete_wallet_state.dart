abstract class DeleteWalletState {
  const DeleteWalletState();
}

class DeleteWalletInitialState extends DeleteWalletState {}

class DeleteWalletOkState extends DeleteWalletState {}

class DeleteWalletFailureState extends DeleteWalletState {
  final String message;

  const DeleteWalletFailureState([this.message = ""]): super();
}
