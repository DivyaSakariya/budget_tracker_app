import 'dart:developer';
import 'dart:typed_data';

import 'package:budget_tracker_app/modals/category_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modals/transaction_modal.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  late Database database;

  String tableBalance = "BalanceTable";
  String tableTransaction = "TransactionTable";
  String tableCategory = "CategoryTable";

  String blnId = "Id";
  String blnAmt = "Amount";

  String trnId = "Id";
  String trnRemarks = "Remarks";
  String trnType = "Type";
  String trnCat = "Category";
  String trnAmt = "Amount";
  String trnDate = "Date";
  String trnTime = "Time";

  String ctgId = "Id";
  String ctgTitle = "Title";
  String ctgImage = "Image";

  init() async {
    log("DB Initializing...");

    String dbPath = await getDatabasesPath();
    String dbFileName = 'DBTable1.db';

    String path = join(dbPath, dbFileName);

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        log("Creating tables !!");

        //Balance Table
        db
            .execute(
                'CREATE TABLE IF NOT EXISTS $tableBalance($blnId INTEGER PRIMARY KEY, $blnAmt INTEGER DEFAULT 0)')
            .then((value) {
          log("Balance table created...");
        }).onError((error, stackTrace) {
          log("Balance table ERROR: $error");
        });
        //Transaction Table
        db
            .execute(
                'CREATE TABLE IF NOT EXISTS $tableTransaction($trnId INTEGER PRIMARY KEY AUTOINCREMENT,$trnRemarks TEXT,$trnType TEXT CHECK($trnType IN("INCOME","EXPANSE")),$trnCat TEXT,$trnAmt INTEGER,$trnDate TEXT,$trnTime TEXT)')
            .then((value) {
          log("Transaction table created...");
        }).onError((error, stackTrace) {
          log("Transaction table Error: $error");
        });

        //Category Table
        db
            .execute(
                'CREATE TABLE IF NOT EXISTS $tableCategory($ctgId INTEGER PRIMARY KEY AUTOINCREMENT, $ctgTitle TEXT, $ctgImage TEXT)')
            .then((value) {
          log("Category table created...");
        }).onError((error, stackTrace) {
          log("Category table Error: $error");
        });
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(1,"Bill","assets/category_img/bill.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(2,"Cash","assets/category_img/cash.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(3,"Communication","assets/category_img/communication.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(4,"Deposit","assets/category_img/deposit.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(5,"Food","assets/category_img/food.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(6,"Gift","assets/category_img/gift.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(7,"Health","assets/category_img/health.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(8,"Movie","assets/category_img/movie.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(9,"Rupee","assets/category_img/rupee.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(10,"Salary","assets/category_img/salary.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(11,"Shopping","assets/category_img/shopping.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(12,"Transport","assets/category_img/transport.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(13,"Wallet","assets/category_img/wallet.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(14,"Withdraw","assets/category_img/withdraw.png")');
        db.rawInsert(
            'INSERT INTO $tableCategory VALUES(15,"Other","assets/category_img/other.png")');
      },
    );
    log("DB path: ${database.path}");
    log("Initialized...");
  }

  Future<int> insertCategory(
      {required String categoryTitle, required Uint8List categoryImage}) async {
    String query =
        "INSERT INTO $tableCategory($ctgTitle, $ctgImage) VALUES(?, ?)";

    List args = [
      categoryTitle,
      categoryImage,
    ];

    return await database.rawInsert(query, args);
  }

  Future<List<CategoryModal>> fetchAllCategory() async {
    List response = await database.rawQuery("SELECT * FROM $tableCategory");

    List<CategoryModal> allCategory =
        response.map((e) => CategoryModal.fromMap(data: e)).toList();

    log("All Category: $allCategory");

    return allCategory;
  }

  Future<int> insertTransaction(
      {required TransactionModal transactionModal}) async {
    String query =
        "INSERT INTO $tableTransaction($trnRemarks,$trnAmt,$trnType,$trnCat,$trnDate,$trnTime) VALUES(?, ?, ?, ?, ?, ?)";

    List args = [
      transactionModal.remarks,
      transactionModal.amount,
      transactionModal.type,
      transactionModal.category,
      transactionModal.date,
      transactionModal.time,
    ];

    return await database.rawInsert(query, args);
  }

  Future<List> fetchAllTransactions() async {
    String query = "SELECT * FROM $tableTransaction";

    List allData = await database.rawQuery(query);

    List<TransactionModal> allTransaction =
        allData.map((e) => TransactionModal.fromMap(data: e)).toList();

    return allTransaction;
  }

  Future<List<TransactionModal>> filterFetchedTransaction(
      {required String type}) async {
    String query = 'SELECT * FROM $tableTransaction WHERE $trnType = "$type"';
    List allData = await database.rawQuery(query);

    List<TransactionModal> allTransaction =
        allData.map((e) => TransactionModal.fromMap(data: e)).toList();

    return allTransaction;
  }

  Future getTotal({required String type}) async {
    String query =
        'SELECT SUM(amount) FROM $tableTransaction WHERE $trnType = "$type"';

    var result = await database.rawQuery(query);

    var value = result[0]["SUM(amount)"];
    print(value);
    return value;
  }

  Future<List<Map>> filterCategory({required String cate}) async {
    String query = "SELECT * FROM $tableTransaction WHERE $trnCat = '$cate'";

    List<Map> l1 = await database.rawQuery(query);
    return l1;
  }

  Future<int> deleteTransaction({required int id}) async {
    String query = "DELETE FROM $tableTransaction WHERE Id = $id";

    return await database.rawDelete(query);
  }

  searchTransaction({required String remarks}) async {
    String query =
        'SELECT * FROM $tableTransaction WHERE $trnRemarks LIKE "%$remarks%"';

    List data = await database.rawQuery(query);

    List<TransactionModal> allData =
        data.map((e) => TransactionModal.fromMap(data: e)).toList();

    return allData;
  }

  updateTransaction({required TransactionModal transactionModal}) async {
    String query =
        'UPDATE $tableTransaction SET $trnRemarks = ?, $trnAmt = ?, $trnCat = ?, $trnType = ? WHERE $trnId = ${transactionModal.id}';

    List args = [
      transactionModal.remarks,
      transactionModal.amount,
      transactionModal.category,
      transactionModal.type,
    ];

    return await database.rawUpdate(query, args);
  }

  setBalance({required int amt}) {
    database.rawUpdate("UPDATE TABLE $tableBalance SET $blnAmt = $amt");
  }
}
