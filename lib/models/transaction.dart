import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  final id;
  final title;
  final amount;
  final date;
  const Transaction({this.amount,this.date,this.id,this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
