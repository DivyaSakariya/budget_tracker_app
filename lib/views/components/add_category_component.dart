import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controllers/category_controller.dart';
import '../../controllers/transaction_controller.dart';
import '../../helpers/utlis/category_utlis.dart';
import '../../modals/category_modal.dart';
import '../../modals/transaction_modal.dart';

class AddCategoryComponent extends StatelessWidget {
  AddCategoryComponent({super.key});

  CategoryController categoryController = Get.put(CategoryController());
  TransactionModal transactionModal = TransactionModal.init();
  CategoryModal categoryModal = CategoryModal.init();
  TransactionController transactionController =
      Get.find<TransactionController>();

  TextEditingController remarksController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  ByteData? imageByteData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Obx(
              () {
                return CupertinoSlidingSegmentedControl(
                  groupValue: categoryController.type.value,
                  children: const {
                    'INCOME': Text("INCOME"),
                    'EXPANSE': Text("EXPANSE"),
                  },
                  onValueChanged: (val) {
                    if (transactionModal.type != 'EXPANSE') {
                      transactionModal.type = 'INCOME';
                    }
                    transactionModal.type = val!;
                    categoryController.selectType(catType: val);
                  },
                );
              },
            ),
            const SizedBox(
              height: 14,
            ),
            const Text("Category"),
            const SizedBox(
              height: 8,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(
                () {
                  return Row(
                    children: [
                      ...List.generate(
                        allCategoryList.length,
                        (index) => GestureDetector(
                          onTap: () async {
                            transactionModal.category =
                                allCategoryList[index]['title'];
                            categoryController.selectIndex(index: index);
                            imageByteData = await rootBundle
                                .load(allCategoryList[index]['image']);
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    (categoryController.bIndex.value == index)
                                        ? Colors.grey
                                        : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    child: Image.asset(
                                        allCategoryList[index]['image']),
                                  ),
                                  const Spacer(),
                                  Text(
                                    allCategoryList[index]['title'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Get.toNamed("/category_list");
            //   },
            //   child: Container(
            //     height: 40,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         width: 2,
            //         color: Colors.grey.shade500,
            //       ),
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 14,
            ),
            const Text("Add Remarks"),
            const SizedBox(
              height: 8,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (val) {
                      transactionModal.remarks = val;
                    },
                    controller: remarksController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Remarks",
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      print("=====================");
                      print(double.parse(val));
                      print("=====================");
                      // transactionModal.amount = val;
                      transactionModal.amount = double.parse(val);
                    },
                    controller: amountController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Amount",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            categoryController.showMyDate(context);
                          },
                          child: const Icon(Icons.date_range_outlined),
                        ),
                        Text(categoryController.date.value),
                      ],
                    );
                  }),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            categoryController.showMyTime(context);
                          },
                          child: const Icon(Icons.access_time),
                        ),
                        Text(categoryController.time.value),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      transactionModal.id = 0;

                      transactionModal.date = categoryController.date.value;
                      transactionModal.time = categoryController.time.value;

                      remarksController.clear();
                      amountController.clear();

                      int id = await transactionController.addTransaction(
                          transactionModal: transactionModal);

                      Get.snackbar("Successfully Transaction Added !!",
                          "Id: $id Category: ${transactionModal.category}");
                    },
                    child: const Text("Save"),
                  ),
                  // ListView.builder(
                  //   itemCount: categoryController.fetchAllCategory.length,
                  //   itemBuilder: (context, index) => Card(
                  //     child: ListTile(
                  //       leading: Image.asset(categoryModal.image!),
                  //       title: Text(categoryModal.title!),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
