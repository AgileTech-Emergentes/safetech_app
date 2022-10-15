class SafetechException {
  const SafetechException([this.error = '']);

  final String error;

  String get firstError => error;

  @override
  String toString() => 'SafetechException{error: $error}';
}
