// class BalanceModal {
//   int id;
//   int amount;
//
//   BalanceModal(
//     this.id,
//     this.amount,
//   );
//
//   factory BalanceModal.fromMap({required Map data}) {
//     return BalanceModal(
//       data['id'],
//       data['amount'],
//     );
//   }
// }

class BalanceModal {
  String name;
  double cost;

  BalanceModal({
    required this.name,
    required this.cost,
  });
}
