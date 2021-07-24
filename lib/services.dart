import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:practice_add_to_list/stock_quote_model.dart';

class StockQuoteServices {
  static Future<StockQuote?> getStockQuote(String ticker) async {
    String url =
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$ticker&apikey=XQQW1OPQ70ZODVES';

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

// class RemoteServices {
//   static var client = http.Client();

//   static Future<StockQuotes?> fetchStockQuotes() async {
//     var response = await client.get(Uri.parse(
//         'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=sq&apikey=XQQW1OPQ70ZODVES'));
//     if (response.statusCode == 200) {
//       return stockQuotesFromJson(jsonString);
//     } else {
//       return null;
//     }
//   }
// }

// Future<StockQuote> getQuotes() async {
//   final response = await http.get(
//     Uri.parse(
//         '${endpoint}markets/quotes?symbols=$stocksWatchlist&greeks=false'),
//     headers: {
//       'Authorization': 'Bearer $accessToken',
//     },
//   );
//   final responseJson = jsonDecode(response.body);

//   return StockQuote.fromJson(responseJson);
// }

// class ApiManager {
//   Future<List<StockQuote>> getStockQuotes() async {
//     String url = endpoint + 'markets/quotes?symbols=' + stocksWatchlist;

//     final response = await http.get(
//       Uri.parse(url),
//       headers: {
//         'Authorization': 'Bearer $accessToken',
//       },
//     );
//     List jsonResponse = json.decode(response.body);
//     return jsonResponse.map((item) => StockQuote.fromJson(item)).toList();
//   }
// }
