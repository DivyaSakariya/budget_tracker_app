import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

    database = await openDatabase(path, version: 1, onCreate: (db, version) {
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
    });

    //Transaction Table
  }
}
