abstract class AddDonasiState {
  const AddDonasiState();
}

class AddDonasiInitialState extends AddDonasiState {}

class AddDonasiOkState extends AddDonasiState {}

class AddDonasiFailureState extends AddDonasiState {
  final String message;

  const AddDonasiFailureState([this.message = ""]);
}