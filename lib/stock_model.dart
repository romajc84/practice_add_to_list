class Stock {
  String symbol;

  Stock({required this.symbol});

  factory Stock.fromJson(Map<String, dynamic> json) =>
      Stock(symbol: json['symbol']);

  Map<String, dynamic> toJson() => {'symbol': symbol};
}
