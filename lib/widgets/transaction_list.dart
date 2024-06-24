import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../widgets/user_transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteExpenses;
  const TransactionList(this.transactions,this.deleteExpenses, {super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.6,
      child: transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'No Expenses Added!',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 20),
                Container(
                    height: mediaQuery.size.height * 0.3,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (expss, index) {
                //An alternative way of building with Listtile
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.purple,
                      radius: 30,
                      child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text(
                            '¢${transactions[index].amount}',
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ))),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                    textColor: Colors.blue,
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: IconButton(onPressed:() => deleteExpenses(transactions[index].id),icon: const Icon(Icons.delete,color: Colors.red,)),
                  ),
                );
                // return Card(
                //   child: Row(
                //     children: [
                //       Container(
                //         margin: const EdgeInsets.symmetric(
                //             vertical: 20, horizontal: 15),
                //         decoration: BoxDecoration(
                //             border: Border.all(
                //           color: Theme.of(context).primaryColorDark,
                //           width: 2,
                //         )),
                //         padding: const EdgeInsets.all(12),
                //         child: Text(
                //           '\$${transactions[index].amount.toStringAsFixed(2)}',
                //           style: const TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 20,
                //               color: Colors.indigo),
                //         ),
                //       ),
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             transactions[index].title,
                //             style: Theme.of(context).textTheme.titleLarge,
                //
                //           ),
                //           Text(
                //             DateFormat.yMMMd().format(transactions[index].date),
                //             style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
