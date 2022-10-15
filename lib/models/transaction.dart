import 'package:flutter/material.dart';

class Transaction {
  const Transaction(
      {required this.amount, this.title, this.content, this.icon});
  final String? title;
  final String? content;
  final Widget? icon;
  final String amount;
}
