import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:practice_add_to_list/stock_model.dart';

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
