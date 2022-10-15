import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/my_wallet_screen/new_expense.dart';

import '../../shared/shared.dart';
import 'my_wallet_screen/new_income.dart';
import 'my_wallet_screen/transaction_option.dart';

class AddTransactionPopup extends StatefulWidget {
  const AddTransactionPopup({Key? key}) : super(key: key);

  @override
  _AddTransactionPopupState createState() => _AddTransactionPopupState();
}

class _AddTransactionPopupState extends State<AddTransactionPopup> {
  final type = Rx<TransactionType>(TransactionType.income);

  onChangedTransactionType(TransactionType type) {
    this.type.value = type;
  }

  Widget _renderTransaction() {
    switch (type.value) {
      case TransactionType.expense:
        return NewExpense();
      case TransactionType.income:
        return NewIncome();
      default:
        return TransactionOption(onPressButton: onChangedTransactionType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: _renderTransaction(),
    );
  }
}
