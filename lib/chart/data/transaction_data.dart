import 'dart:math';

import '../../modals/balance_modal.dart';

final random = Random();
final List<double> weeklySpending = [
  random.nextDouble() * 100,
  random.nextDouble() * 100,
  random.nextDouble() * 100,
  random.nextDouble() * 100,
  random.nextDouble() * 100,
  random.nextDouble() * 100,
  random.nextDouble() * 100,
];

_generateExpenses() {
  List<BalanceModal> balanceModal = [
    BalanceModal(name: 'Item 0', cost: random.nextDouble() * 90),
    BalanceModal(name: 'Item 1', cost: random.nextDouble() * 90),
    BalanceModal(name: 'Item 2', cost: random.nextDouble() * 90),
    BalanceModal(name: 'Item 3', cost: random.nextDouble() * 90),
    BalanceModal(name: 'Item 4', cost: random.nextDouble() * 90),
    BalanceModal(name: 'Item 5', cost: random.nextDouble() * 90),
  ];
  return balanceModal;
}
