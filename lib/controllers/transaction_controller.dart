import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/db_helper.dart';
import '../modals/transaction_modal.dart';

class TransactionController extends GetxController {
  final RxList<TransactionModal> _allTransaction = <TransactionModal>[].obs;
  final RxList<TransactionModal> _searchTransaction = <TransactionModal>[].obs;
  final RxInt _dateBalance = 0.obs;
  RxInt totalBalance = 0.obs;

  RxBool canEdit = false.obs;

  editTran() {
    canEdit(!canEdit.value);
  }

  TransactionController() {
    init();
    DateTime d = DateTime.now();

    String currentDate = "${d.day}/${d.month}/${d.year}";

    date(currentDate);
  }

  init() async {
    _allTransaction((await DBHelper.dbHelper.fetchAllTransactions())
        .cast<TransactionModal>());
  }

  Future<int> addTransaction({required TransactionModal transactionModal}) {
    return DBHelper.dbHelper
        .insertTransaction(transactionModal: transactionModal);
  }

  RxList<TransactionModal> get fetchAllTransactions {
    return _allTransaction;
  }

  Future<int> delete({required int id}) async {
    init();

    if (_allTransaction.any((element) => element.id == id)) {
      return await DBHelper.dbHelper.deleteTransaction(id: id);
    } else {
      Get.snackbar("ERROR !!", "$id does not exist...");
      return 0;
    }
  }

  search({required String remarks}) async {
    _searchTransaction(
        await DBHelper.dbHelper.searchTransaction(remarks: remarks));
  }

  RxList<TransactionModal> get searchTransaction {
    return _searchTransaction;
  }

  updateBalance({required int amt}) async {
    _dateBalance(await DBHelper.dbHelper.setBalance(amt: amt));
  }

  RxInt get dateIncomeTotal {
    return _dateBalance;
  }

  calculateTotalBalance() {
    totalBalance = fetchAllTransactions.fold(
      0.obs,
      (sum, expense) => sum += expense.amount!,
    );
  }

  RxString date = "".obs;
  RxInt dateBalance = 0.obs;

  showDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1965),
      lastDate: DateTime(2999),
    );

    if (pickDate != null) {
      String formattedDate =
          "${pickDate.day}/${pickDate.month}/${pickDate.year}";
      // DateFormat("dd/MM/yyyy").format(pickDate);
      date(formattedDate);
    }
  }

  calculateDateBalance() {
    dateBalance = fetchAllTransactions.fold(
      0.obs,
          (sum, expense) {
        DateTime d = DateTime.now();
        String date = "${d.day}/${d.month}/${d.year}";

        if (expense.date == date) {
          sum += expense.amount!;
        }
        return sum;
      },
    );
  }

// RxList<TransactionModal> list1 = <TransactionModal>[].obs;
// RxInt total = 0.obs;

// Future<void> totalIncomeExpanse() async {
//   list1 = fetchAllTransactions;
//
//   for (int i = 0; i < list1.length; i++) {
//     if (list1[i].type == "INCOME") {
//       total += int.parse("${list1[i].amount}");
//     } else {
//       total -= int.parse("${list1[i].amount}");
//     }
//     print("${total}--------------------");
//   }
//
//   print("$total");
// }

// balanceUpdate({required int amt}) {
//   DBHelper.dbHelper.setBalance(amt: amt);
// }
//
// dateTotalIncome({required DateTime dateTime}) {
//   String date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
//   _allTransaction.every((element) {
//     log("${int.parse(element.date!.split('-')[0])}");
//     log("${int.parse(date.split('-')[0])}");
//     if ((int.parse(element.date!.split('-')[0])) <=
//         (int.parse(date.split('-')[0]))) {
//       element.type == 'INCOME'
//           ? dateIncomeTotal.value += element.amount!
//           : dateIncomeTotal.value -= element.amount!;
//       log("${dateIncomeTotal.value}");
//     }
//     return (int.parse(element.date!.split('-')[0]) <=
//         int.parse(date.split('-')[0]));
//   });
// }

// RxInt datesum;
//
// datewise({required DateTime dateTime}) {
//   datesum.value = 0;
//   String date = DateFormat('dd-MM-yyyy').format(dateTime);
//   _allTransaction.every((element) {
//     log("${(int.parse(element.date.split('-')[0]))}");
//     log("${(int.parse(date.split('-')[0]))}");
//     if ((int.parse(element.date.split('-')[0]) <=
//         int.parse(date.split('-')[0]))) {
//       element.type == 'income'
//           ? datesum.value += element.amt
//           : datesum.value -= element.amt;
//       log("${datesum.value}");
//     }
//     return (int.parse(element.date.split('-')[0]) <=
//         int.parse(date.split('-')[0]));
//   });
// }
}
