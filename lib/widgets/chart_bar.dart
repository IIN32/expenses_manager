import 'package:flutter/material.dart';

class ChartBars extends StatelessWidget {
  final label;
  final double amountExpenses;
  final double totalExpenses;
  const ChartBars(this.label, this.amountExpenses, this.totalExpenses,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (expn, constraints){
      return Column(
        children: [
          Container(
            height: constraints.maxHeight *0.14,
            child: FittedBox(
              child: Text(
                '¢${amountExpenses.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,fontSize: 18,
                ),
              ),
            ),
          ),
           SizedBox(
            height: constraints.maxHeight *0.010,
          ),
          Container(
            height: constraints.maxHeight *0.6,
            width: 10,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, width: 1),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FractionallySizedBox(
                heightFactor: totalExpenses,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ]),
          ),
           SizedBox(
            height: constraints.maxHeight *0.1,
          ),
          Container(
            height: constraints.maxHeight *0.15,
            child: FittedBox(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    });

  }
}
