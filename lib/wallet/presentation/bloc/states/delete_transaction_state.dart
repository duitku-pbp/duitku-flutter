abstract class DeleteTransactionState {
  const DeleteTransactionState();
}

class DeleteTransactionInitialState extends DeleteTransactionState {}

class DeleteTransactionOkState extends DeleteTransactionState {}

class DeleteTransactionFailureState extends DeleteTransactionState {
  final String message;

  const DeleteTransactionFailureState([this.message = ""]) : super();
}
