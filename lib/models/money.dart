import 'dart:convert';
import 'dart:ffi';

class Money {
  int amount;
  String currency;

  Money({
    required this.amount,
    required this.currency,
  });

  factory Money.fromJson(Map<String, dynamic> json) {
    return Money(
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