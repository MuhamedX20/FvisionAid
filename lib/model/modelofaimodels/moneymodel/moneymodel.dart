class Money {
  String cash;

  Money({
    required this.cash,
  });

  factory Money.fromJson(Map<String, dynamic> json) => Money(
    cash: json["Cash"],
  );

}


