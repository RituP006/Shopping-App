class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    return message;
  }
}

// Exception is a abstract class that means we can't directly intantiate it.

// by implementing Exception class, we are signing a contract, such that we are forced to implement all functions this class has.
// here we override the toString() method of this class to return an exception message.
