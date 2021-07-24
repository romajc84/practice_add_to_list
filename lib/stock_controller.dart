import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:practice_add_to_list/services.dart';
import 'package:practice_add_to_list/stock_model.dart';
import 'package:practice_add_to_list/stock_quote_model.dart';

class StockController extends GetxController {
  var stocks = [].obs;

  void add(Stock s) {
    stocks.add(s);
  }

  @override
  void onInit() {
    List? storedStocks = GetStorage().read<List>('stocks');
    if (storedStocks != null) {
      stocks = storedStocks.map((e) => Stock.fromJson(e)).toList().obs;
    }
    ever(stocks, (_) {
      GetStorage().write('stocks', stocks.toList());
    });
    super.onInit();
  }
}

class StockQuoteController extends GetxController {
  var isLoading = true.obs;
  var stockQuote = StockQuote().obs;

  @override
  void onInit() {
    getStockQuote();
    super.onInit();
  }

  void getStockQuote() async {
    try {
      isLoading(true);
      var data = await StockQuoteServices.getStockQuote();
      if (data != null) {
        stockQuote.value = data;
      }
    } finally {
      isLoading(false);
    }
  }
}
