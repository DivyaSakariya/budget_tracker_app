import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/transaction_controller.dart';
import '../../modals/transaction_modal.dart';
import '../../utils/category_utils.dart';

class SearchComponent extends StatelessWidget {
  SearchComponent({super.key});

  TransactionController transactionController =
      Get.find<TransactionController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: (val) {
              transactionController.search(remarks: val);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Search Transaction",
              suffixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: Obx(() {
              return transactionController.allTransaction.isNotEmpty
                  ? ListView.builder(
                      itemCount:
                          transactionController.searchTransaction.length,
                      itemBuilder: (context, index) {
                        TransactionModal transactionModal =
                            transactionController
                                .searchTransaction[index];

                        var image = allCategoryList.where((element) =>
                            element['title'] == transactionModal.category);

                        String img = image.toList()[0]['image'];
                        return Card(
                          child: ListTile(
                            leading: Image.asset(img),
                            title: Text(transactionModal.remarks!),
                            trailing: Text(
                              "${transactionModal.amount}",
                              style: TextStyle(
                                color: transactionModal.type == "INCOME"
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                        );
                      })
                  : const Center(
                      child: Text("Yet Transaction Not Found...!!"),
                    );
            }),
          ),
        ],
      ),
    );
  }
}
