import 'package:budget_tracker_app/controllers/transaction_controller.dart';
import 'package:budget_tracker_app/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors_utils.dart';

class GraphComponent extends StatelessWidget {
  const GraphComponent({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionController controller = Get.put(TransactionController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Transactions",
            style: GoogleFonts.lato(
              fontSize: 17.sp,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
              color: kTextColor,
            ),
          ),
          backgroundColor: const Color(0xff13232e),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 5.h,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.allTransaction();
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff13232e)),
                        child: Text(
                          "All",
                          style: GoogleFonts.lato(
                            fontSize: 13.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500,
                            color: kTextColor,
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          controller.filterFetchedTran(statusCode: "Income");
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff13232e)),
                        child: Text(
                          "Income",
                          style: GoogleFonts.lato(
                            fontSize: 13.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500,
                            color: kTextColor,
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          controller.filterFetchedTran(statusCode: "Expense");
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff13232e)),
                        child: Text(
                          "Expense",
                          style: GoogleFonts.lato(
                            fontSize: 13.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500,
                            color: kTextColor,
                          ),
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Obx(
                () => SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: controller.allTransaction.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF17202A),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: Offset(1, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 83,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(1, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${controller.allTransaction[index]}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 83,
                                      decoration: BoxDecoration(
                                        color: controller.allTransaction[index]
                                                    .type ==
                                                "Income"
                                            ? Colors.green.shade200
                                            : Colors.red.shade200,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(1, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${controller.allTransaction[index].type}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "${controller.allTransaction[index].amount}",
                                  style: GoogleFonts.lato(
                                    fontSize: 14.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor,
                                  ),
                                ),
                                Text(
                                  "${controller.allTransaction[index].remarks}",
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor,
                                  ),
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            Column(
                              children: [
                                Text(
                                  "${controller.allTransaction[index].date}",
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor,
                                  ),
                                ),
                                Text(
                                  "${controller.allTransaction[index].time}",
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.toNamed("/add", arguments: {
                                          "option": 0,
                                          "index": index
                                        });
                                      },
                                      icon: Icon(Icons.edit,
                                          color: Colors.grey.shade700),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        DBHelper.dbHelper.deleteTransaction(
                                            id: controller
                                                .allTransaction[index].id!);

                                        controller.init();
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Colors.red.shade300),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
