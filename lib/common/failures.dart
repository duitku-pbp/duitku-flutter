abstract class Failure {
  String message;

  Failure(this.message);
}

class HttpFailure extends Failure {
  HttpFailure(String message) : super(message);
}
