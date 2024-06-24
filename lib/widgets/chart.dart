import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  Chart(this.recentTransactions, {super.key});

  List<Map<String, Object>> get allExpenses {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalAmount = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount = totalAmount + recentTransactions[i].amount;
        }
      }
      // print(DateFormat.E().format(weekDay).substring(0, 1));
      // print(totalAmount);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get maxExpenses {
    return allExpenses.fold(0.0, (totals, item) {
      return totals + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.2,
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: allExpenses.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBars(
                  data['day'],
                  (data['amount'] as double),
                  maxExpenses == 0.0 ? 0.0 :(data['amount'] as double) / maxExpenses,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
