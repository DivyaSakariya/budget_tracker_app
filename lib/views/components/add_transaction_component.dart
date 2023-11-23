import 'package:budget_tracker_app/helpers/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/transaction_controller.dart';
import '../../modals/transaction_modal.dart';
import '../../utils/colors_utils.dart';

// class AddTransactionComponent extends StatelessWidget {
//   AddTransactionComponent({super.key});
//
//   CategoryController categoryController = Get.put(CategoryController());
//   TransactionModal transactionModal = TransactionModal.init();
//   CategoryModal categoryModal = CategoryModal.init();
//   TransactionController transactionController =
//       Get.find<TransactionController>();
//
//   TextEditingController remarksController = TextEditingController();
//   TextEditingController amountController = TextEditingController();
//
//   ByteData? imageByteData;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Transaction"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             Obx(
//               () {
//                 return CupertinoSlidingSegmentedControl(
//                   groupValue: categoryController.type.value,
//                   children: const {
//                     'INCOME': Text("INCOME"),
//                     'EXPANSE': Text("EXPANSE"),
//                   },
//                   onValueChanged: (val) {
//                     transactionModal.type = val!;
//                     categoryController.selectType(catType: val);
//                   },
//                 );
//               },
//             ),
//             const SizedBox(
//               height: 14,
//             ),
//             const Text("Category"),
//             const SizedBox(
//               height: 8,
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Obx(
//                 () {
//                   return Row(
//                     children: [
//                       ...List.generate(
//                         allCategoryList.length,
//                         (index) => GestureDetector(
//                           onTap: () async {
//                             transactionModal.category =
//                                 allCategoryList[index]['title'];
//                             categoryController.selectIndex(index: index);
//                             imageByteData = await rootBundle
//                                 .load(allCategoryList[index]['image']);
//                           },
//                           child: Container(
//                             height: 150,
//                             width: 150,
//                             margin: const EdgeInsets.all(4),
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color:
//                                     (categoryController.bIndex.value == index)
//                                         ? Colors.grey
//                                         : Colors.transparent,
//                                 width: 2,
//                               ),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(14),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     height: 60,
//                                     child: Image.asset(
//                                         allCategoryList[index]['image']),
//                                   ),
//                                   const Spacer(),
//                                   Text(
//                                     allCategoryList[index]['title'],
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(
//               height: 14,
//             ),
//             const Text("Add Remarks"),
//             const SizedBox(
//               height: 8,
//             ),
//             Form(
//               child: Column(
//                 children: [
//                   TextFormField(
//                     onChanged: (val) {
//                       transactionModal.remarks = val;
//                     },
//                     controller: remarksController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Enter Remarks",
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 14,
//                   ),
//                   TextFormField(
//                     onChanged: (val) {
//                       print("=====================");
//                       print(double.parse(val));
//                       print("=====================");
//                       transactionModal.amount = int.parse(val);
//                       // transactionModal.amount = val;
//                       // transactionModal.amount = double.parse(val);
//                     },
//                     controller: amountController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Enter Amount (₹)",
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Obx(() {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             categoryController.showMyDate(context);
//                           },
//                           child: const Icon(Icons.date_range_outlined),
//                         ),
//                         Text(categoryController.date.value),
//                       ],
//                     );
//                   }),
//                   Obx(() {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             categoryController.showMyTime(context);
//                           },
//                           child: const Icon(Icons.access_time),
//                         ),
//                         Text(categoryController.time.value),
//                       ],
//                     );
//                   }),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       transactionModal.id = 0;
//
//                       transactionModal.date = categoryController.date.value;
//                       transactionModal.time = categoryController.time.value;
//
//                       remarksController.clear();
//                       amountController.clear();
//
//                       int id = await transactionController.addTransaction(
//                           transactionModal: transactionModal);
//
//                       Get.snackbar("Successfully Transaction Added !!",
//                           "Id: $id Category: ${transactionModal.category}");
//
//                       transactionController.init();
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text("Save"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AddTransactionComponent extends StatefulWidget {
  const AddTransactionComponent({super.key});

  @override
  State<AddTransactionComponent> createState() => _AddTransactionComponentState();
}

class _AddTransactionComponentState extends State<AddTransactionComponent> {
  TransactionController controller = Get.put(TransactionController());
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtNotes = TextEditingController();
  TextEditingController txtTags = TextEditingController();

  Map mapData = {};

  @override
  void initState() {
    super.initState();
    mapData = Get.arguments!;

    if (mapData['option'] == 0) {
      int index = mapData['index'];
      controller.inClick.value = controller.allTransaction[index].category!;
      txtAmount = TextEditingController(
          text: "${controller.allTransaction[index].amount}");
      txtNotes = TextEditingController(
          text: "${controller.allTransaction[index].remarks}");
      // controller.date =  controller.dataList[index]['date'];
      // controller.time =  controller.dataList[index]['time'];
      controller.dropDown.value = controller.allTransaction[index].type!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          titleSpacing: 2,
          title: Text(
            mapData['option'] == 1 ? "Add Category" : "Update",
            style: GoogleFonts.lato(
              fontSize: 12.sp,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w500,
              color: kTextColor,
            ),
          ),
          backgroundColor: const Color(0xFF17202A),
          actions: [
            DropdownButton(
              hint: Text(
                controller.dropDown.value,
                style: const TextStyle(color: Colors.white),
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              items: ["Income", "Expense"].map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.lato(
                      fontSize: 13.sp,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  controller.dropDown.value = newValue!;
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: txtAmount,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    border: UnderlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide.none,
                    ),
                    labelText: "Amount",
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.currency_rupee,
                      color: Color(0xFF32B3DF),
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  height: 1,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
                TextField(
                  controller: txtNotes,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    border: UnderlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide.none,
                    ),
                    labelText: "note",
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.notes_rounded,
                      color: Color(0xFF32B3DF),
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  height: 1,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        controller.date = (await showDatePicker(
                            context: context,
                            initialDate: controller.currentDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030)))!;
                        controller.changeDate(controller.date);
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Obx(
                      () => Text(
                        "${controller.day.value}/${controller.mon.value}/${controller.year.value}",
                        style: GoogleFonts.lato(
                          fontSize: 16.sp,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                          color: kTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  height: 1,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        controller.time = (await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                                hour: controller.currentTime.hour,
                                minute: controller.currentTime.minute)))!;
                        controller.changeTime(controller.time);
                      },
                      icon: const Icon(Icons.access_time_filled_rounded),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Obx(
                      () => Text(
                        "${controller.hour.value}:${controller.minute.value}",
                        style: GoogleFonts.lato(
                          fontSize: 16.sp,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                          color: kTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  height: 1,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "          Category",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          color: Color(0xFF32B3DF), shape: BoxShape.circle),
                      child: const Icon(Icons.more_horiz, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Obx(
                      () => Text(
                        controller.inClick.value,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                          content: ShowDialogCate(),
                          backgroundColor: const Color(0xFF17202A),
                          title: "Categories",
                          titleStyle: const TextStyle(
                              fontSize: 25, color: Colors.white),
                        );
                      },
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  height: 1,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (mapData['option'] == 0) {
              TransactionModal transactionModal = TransactionModal(
                controller.allTransaction[mapData['index']].id,
                txtNotes.text,
                controller.dropDown.value,
                controller.inClick.value,
                int.parse(txtAmount.text),
                "${controller.day.value}/${controller.mon.value}/${controller.year.value}",
                "${controller.hour.value}:${controller.minute.value}",
              );

              await DBHelper.dbHelper
                  .updateTransaction(transactionModal: transactionModal);
            } else {
              TransactionModal transactionModal = TransactionModal(
                controller.allTransaction[mapData['index']].id,
                txtNotes.text,
                controller.dropDown.value,
                controller.inClick.value,
                int.parse(txtAmount.text),
                "${controller.day.value}/${controller.mon.value}/${controller.year.value}",
                "${controller.hour.value}:${controller.minute.value}",
              );

              await DBHelper.dbHelper
                  .insertTransaction(transactionModal: transactionModal);
            }
            await controller.init();
            Get.back();
          },
          backgroundColor: const Color(0xFF17202A),
          child: const Icon(Icons.account_balance_wallet_rounded,
              color: Colors.white),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ShowDialogCate() {
    return SizedBox(
      width: 200,
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        controller.changeCategory(controller.categories[index]);
                        Get.back();
                      },
                      child: Obx(
                        () => Text(
                          "${controller.categories[index]}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: controller.categories.length,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                backgroundColor: Colors.white,
                title: "Add the category",
                titleStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                content: categoryDialog(),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              "Add Category",
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryDialog() {
    return Column(
      children: [
        TextField(
          controller: txtcate,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Category"),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              controller.categories.add(txtcate.text);
              controller.totalIncome("Income");
              controller.totalIncome("Expense");
            });
            Get.back();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF17202A)),
          child: const Text("Add"),
        ),
      ],
    );
  }
}
