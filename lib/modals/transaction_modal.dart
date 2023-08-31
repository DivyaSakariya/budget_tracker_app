import 'dart:developer';

class TransactionModal {
  int? id;
  String? remarks;
  String? type;
  String? category;
  String? amount;
  String? date;
  String? time;

  TransactionModal(
    this.id,
    this.remarks,
    this.type,
    this.category,
    this.amount,
    this.date,
    this.time,
  );

  TransactionModal.init() {
    log("Empty transaction initialized...!!!");
  }

  factory TransactionModal.fromMap({required Map data}) {
    return TransactionModal(
      data['Id'],
      data['Remarks'],
      data['Type'],
      data['Category'],
      data['Amount'].toString(),
      data['Date'],
      data['Time'],
    );
  }
}
