import 'dart:convert';
class Address {
  String street;
  String city;
  String country;

  Address({
    required this.street,
    required this.city,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json["street"],
      city: json["city"],
      country: json["country"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "street": street,
      "city": city,
      "country": country,
    };
  }
}