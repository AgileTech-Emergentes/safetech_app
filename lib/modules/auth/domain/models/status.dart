class Status {
  const Status(this._value);

  final int _value;

  //Constructores constantes
  static const Status unknown = Status(1);
  static const Status authenticated = Status(2);
  static const Status unauthenticated = Status(3);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Status && other._value == _value;
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => 'Status: {_value: $_value}';

  bool get isUnknown => this == unknown;
  bool get isAuthenticated => this == authenticated;
  bool get isUnauthenticated => this == unauthenticated;

}
