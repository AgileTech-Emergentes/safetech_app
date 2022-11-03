class DiagnosisCost {
  int amount;
  String currency;

  DiagnosisCost({
    required this.amount,
    required this.currency,
  });

  factory DiagnosisCost.fromJson(Map<String, dynamic> json) {
    return DiagnosisCost(
      amount: json["amount"],
      currency: json["currency"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "currency": currency,
    };
  }
}