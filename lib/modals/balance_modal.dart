class BalanceModal {
  int id;
  int amount;

  BalanceModal(
    this.id,
    this.amount,
  );

  factory BalanceModal.fromMap({required Map data}) {
    return BalanceModal(
      data['id'],
      data['amount'],
    );
  }
}
