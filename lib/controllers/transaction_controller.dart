import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/db_helper.dart';
import '../modals/transaction_modal.dart';

class TransactionController extends GetxController {
  RxString imgPath = "".obs;
  Uint8List? byte;
  RxString inClick = "".obs;
  RxString onclick = "".obs;
  RxString dropDown = "Income".obs;
  RxInt Income = 0.obs;
  RxInt Expense = 0.obs;
  RxInt total = 0.obs;

  final RxList<TransactionModal> allTransaction = <TransactionModal>[].obs;
  final RxList<TransactionModal> _searchTransaction = <TransactionModal>[].obs;
  final RxInt _dateBalance = 0.obs;
  RxInt totalBalance = 0.obs;

  RxBool canEdit = false.obs;

  editTran() {
    canEdit(!canEdit.value);
  }

  TransactionController() {
    init();
  }

  RxList categories = [
    "Salary",
    "Food an Dining",
    "Shopping",
    "Travelling",
    "Entertainment",
    "Medical",
    "Personal Care",
    "Education",
    "Bills and Utilities",
    "Investments",
    "Rent",
    "Taxes",
    "Insurance",
    "Gifts and Donation",
    "Coupons",
    "Sold items"
  ].obs;

  void changeCategory(String category) {
    inClick.value = category;
  }

  // Date Time
  var currentDateFrom = DateTime.now();
  var From = DateTime.now();
  RxInt fromDay = 0.obs;
  RxInt fromMonth = 0.obs;
  RxInt fromYear = 0.obs;

  void inch1() {
    currentDateTo = DateTime.now();
    currentDateFrom = DateTime.now();
    changeFromDate(currentDateFrom);
    changeToDate(currentDateTo);
  }

  void changeFromDate(From) {
    currentDateFrom = From;
    fromDay.value = currentDateFrom.day;
    fromMonth.value = currentDateFrom.month;
    fromYear.value = currentDateFrom.year;
    update();
  }

  var currentDateTo = DateTime.now();
  var To = DateTime.now();
  RxInt toDay = 0.obs;
  RxInt toMonth = 0.obs;
  RxInt toYear = 0.obs;

  void changeToDate(To) {
    currentDateTo = To;
    toDay.value = currentDateTo.day;
    toMonth.value = currentDateTo.month;
    toYear.value = currentDateTo.year;
    update();
  }

  RxInt day = 0.obs;
  RxInt mon = 0.obs;
  RxInt year = 0.obs;
  RxInt hour = 0.obs;
  RxInt minute = 0.obs;

  // Time
  var currentDate = DateTime.now();
  var date = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  TimeOfDay time = TimeOfDay.now();

  void inch() {
    currentDate = DateTime.now();
    changeDate(currentDate);
  }

  void changeDate(date) {
    currentDate = date;
    day.value = currentDate.day;
    mon.value = currentDate.month;
    year.value = currentDate.year;
    update();
  }

  void changeTime(time) {
    currentTime = time;
    hour.value = currentTime.hour;
    minute.value = currentTime.minute;
    update();
  }

  Future<void> init() async {
    allTransaction((await DBHelper.dbHelper.fetchAllTransactions())
        .cast<TransactionModal>());
  }

  Future<void> getCategory(String category) async {
    allTransaction((await DBHelper.dbHelper.filterCategory(cate: category))
        .cast<TransactionModal>());
  }

  Future<void> filterFetchedTran({statusCode}) async {
    allTransaction(
        (await DBHelper.dbHelper.filterFetchedTransaction(type: statusCode))
            .cast<TransactionModal>());
  }

  Future<void> totalExpense(String type) async {
    Expense(await DBHelper.dbHelper.getTotal(type: type));
  }

  Future<void> totalIncome(String type) async {
    Income(await DBHelper.dbHelper.getTotal(type: type));
  }

  Future<int> addTransaction({required TransactionModal transactionModal}) {
    return DBHelper.dbHelper
        .insertTransaction(transactionModal: transactionModal);
  }

  Future<int> delete({required int id}) async {
    init();

    if (allTransaction.any((element) => element.id == id)) {
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

// updateBalance({required int amt}) async {
//   _dateBalance(await DBHelper.dbHelper.setBalance(amt: amt));
// }

// RxInt get dateIncomeTotal {
//   return _dateBalance;
// }

// calculateTotalBalance() {
//   totalBalance = fetchAllTransactions.fold(
//     0.obs,
//     (sum, expense) => sum += expense.amount!,
//   );
// }

// RxString date = "".obs;
// RxInt dateBalance = 0.obs;

// showDate(BuildContext context) async {
//   DateTime? pickDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(1965),
//     lastDate: DateTime(2999),
//   );
//
//   if (pickDate != null) {
//     String formattedDate =
//         "${pickDate.day}/${pickDate.month}/${pickDate.year}";
//     // DateFormat("dd/MM/yyyy").format(pickDate);
//     date(formattedDate);
//   }
// }

// calculateDateBalance() {
//   dateBalance = fetchAllTransactions.fold(
//     0.obs,
//     (sum, expense) {
//       DateTime d = DateTime.now();
//       String date = "${d.day}/${d.month}/${d.year}";
//
//       if (expense.date == date) {
//         sum += expense.amount!;
//       }
//       return sum;
//     },
//   );
// }
}
