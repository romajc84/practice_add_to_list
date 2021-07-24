import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:practice_add_to_list/stock_quote_model.dart';

class StockQuoteServices {
  static Future<StockQuote?> getStockQuote() async {
    String url =
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=sq&apikey=XQQW1OPQ70ZODVES';

    http.Response response;
    response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      StockQuote stockQuote = StockQuote.fromJson(json.decode(response.body));
      return stockQuote;
    } else {
      return null;
    }
  }
}
