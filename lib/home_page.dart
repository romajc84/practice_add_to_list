import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_add_to_list/stock_controller.dart';
import 'package:practice_add_to_list/stock_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StockController sC = Get.put(StockController());
    final StockQuoteController sQC = Get.put(StockQuoteController());

    TextEditingController tEC = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to List Practice'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 0, 100, 10),
                    child: TextField(
                      controller: tEC,
                      autofocus: true,
                      maxLines: 1,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        labelText: 'Add Stock',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSubmitted: (text) {
                        sC.stocks.add(Stock(symbol: tEC.text));
                        tEC.clear();
                        Get.back();
                      },
                    ),
                  ),
                  // SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      sC.stocks.add(Stock(symbol: tEC.text));
                      tEC.clear();
                      Get.back();
                    },
                    child: Text('Enter'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            enableDrag: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            backgroundColor: Colors.white,
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Obx(
            () => ListView.separated(
              itemCount: sC.stocks.length,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black,
                  thickness: 0.1,
                  height: 0.0,
                );
              },
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    sC.stocks.removeAt(index);
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    leading: Text(
                      sC.stocks[index].symbol,
                    ),
                    trailing: Obx(() {
                      if (sQC.isLoading.value) {
                        return Text('loading');
                      } else {
                        return Text(
                            sQC.stockQuote.value.globalQuote!.price as String);
                      } // stuck here!
                    }),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
