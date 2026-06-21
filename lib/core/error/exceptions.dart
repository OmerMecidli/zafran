class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server xətası baş verdi']);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'İnternet bağlantısını yoxlayın']);

  @override
  String toString() => message;
}

