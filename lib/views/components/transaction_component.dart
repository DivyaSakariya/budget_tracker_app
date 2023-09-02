import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/transaction_controller.dart';
import '../../helpers/utlis/category_utlis.dart';
import '../../modals/transaction_modal.dart';

class TransactionComponent extends StatelessWidget {
  TransactionComponent({super.key});

  TransactionController transactionController =
      Get.find<TransactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: transactionController.fetchAllTransactions.value.isNotEmpty
              ? ListView.builder(
                  itemCount:
                      transactionController.fetchAllTransactions.value.length,
                  itemBuilder: (context, index) {
                    TransactionModal transactionModal =
                        transactionController.fetchAllTransactions.value[index];

                    var image = allCategoryList.where((element) =>
                        element['title'] == transactionModal.category);

                    log("IMG DATA: ${image.toList()[0]['image']}");

                    String img = image.toList()[0]['image'];

                    return Card(
                      child: ListTile(
                        onLongPress: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text(transactionModal.remarks!),
                              // content: Obx(() {
                              //   return Visibility(
                              //     visible: transactionController.canEdit.value,
                              //     child: Form(
                              //       child: Column(
                              //         children: [
                              //           TextFormField(
                              //             initialValue:
                              //                 transactionModal.category,
                              //           ),
                              //           TextFormField(
                              //             initialValue:
                              //                 transactionModal.remarks,
                              //           ),
                              //           TextFormField(
                              //             initialValue: transactionModal.amount
                              //                 .toString(),
                              //           ),
                              //           CupertinoSlidingSegmentedControl(
                              //             groupValue: transactionModal.type,
                              //             children: const {
                              //               'INCOME': Text("INCOME"),
                              //               'EXPANSE': Text("EXPANSE"),
                              //             },
                              //             onValueChanged: (val) {
                              //               transactionModal.type = val!;
                              //             },
                              //           ),
                              //           Row(
                              //             children: [
                              //               TextFormField(
                              //                 initialValue:
                              //                     transactionModal.date,
                              //               ),
                              //               TextFormField(
                              //                 initialValue:
                              //                     transactionModal.time,
                              //               ),
                              //             ],
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   );
                              // }),
                              actions: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // transactionController.editTran();
                                    Get.toNamed('/edit_transaction',
                                        arguments: transactionModal);
                                  },
                                  icon: const Icon(Icons.edit),
                                  label: const Text("Edit"),
                                ),
                                TextButton.icon(
                                  onPressed: () async {
                                    await transactionController.delete(
                                        id: transactionModal.id!);

                                    Get.snackbar("Deleted",
                                        "${transactionModal.id} ${transactionModal.remarks}");

                                    transactionController.init();

                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.delete),
                                  label: const Text("Delete"),
                                ),
                              ],
                            ),
                          );
                        },
                        leading: Image.asset(img),
                        title: Text(transactionModal.remarks!),
                        subtitle: Text(
                            "${transactionModal.date} ${transactionModal.time}"),
                        trailing: Text(
                          transactionModal.type == "INCOME"
                              ? "+₹${transactionModal.amount}"
                              : "-₹${transactionModal.amount}",
                          style: TextStyle(
                            color: transactionModal.type == "INCOME"
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    );
                  })
              : transactionController.fetchAllTransactions.value.isEmpty
                  ? const Center(
                      child: Text("Yet No Transaction Added..!!"),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
        );
      },
    );
  }
}
