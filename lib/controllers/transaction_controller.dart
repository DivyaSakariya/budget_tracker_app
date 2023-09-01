import 'package:get/get.dart';

import '../helpers/db_helper.dart';
import '../modals/transaction_modal.dart';

class TransactionController extends GetxController {
  final RxList<TransactionModal> _allTransaction = <TransactionModal>[].obs;
  final RxList<TransactionModal> _searchTransaction = <TransactionModal>[].obs;

  bool canEdit = false;

  editTran() {
    canEdit = !canEdit;
    update();
  }

  TransactionController() {
    init();
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
}
