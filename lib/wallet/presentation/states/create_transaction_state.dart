abstract class CreateTransactionState {
  const CreateTransactionState();
}

class CreateTransactionInitialState extends CreateTransactionState {}

class CreateTransactionOkState extends CreateTransactionState {}

class CreateTransactionFailureState extends CreateTransactionState {
  final String message;

  const CreateTransactionFailureState([this.message = ""]) : super();
}
