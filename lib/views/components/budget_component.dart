import 'dart:math';

import 'package:budget_tracker_app/controllers/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetComponent extends StatelessWidget {
  BudgetComponent({super.key});

  TransactionController transactionController =
      Get.find<TransactionController>();

  @override
  Widget build(BuildContext context) {
    transactionController.calculateTotalBalance();
    transactionController.calculateDateBalance();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("Total Balance"),
              Text("₹${transactionController.totalBalance}"),
              // Text("₹${transactionController.total}"),
              Row(
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      const Text("Income"),
                      Text("+₹${transactionController.fetchAllTransactions.fold(
                        0,
                        (sum, expense) {
                          if (expense.type == "INCOME") {
                            sum += expense.amount!;
                          }
                          return sum;
                        },
                      )}"),
                    ],
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  Column(
                    children: [
                      const Text("Expanse"),
                      Text("₹${transactionController.fetchAllTransactions.fold(
                        0,
                        (sum, expense) {
                          if (expense.type == "EXPANSE") {
                            sum -= expense.amount!;
                          }
                          return sum;
                        },
                      )}"),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              Text("Date"),
              Text("${transactionController.fetchAllTransactions.fold(
                0,
                (sum, expense) {
                  DateTime d = DateTime.now();
                  String date = "${d.day}/${d.month}/${d.year}";

                  if (expense.date == date) {
                    sum += expense.amount!;
                  }
                  return sum;
                },
              )}"),
            ],
          ),
        ),
      ),
    );
  }
}
