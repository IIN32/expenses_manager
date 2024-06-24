import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addExp;

  const NewTransaction(this.addExp, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime _chosenExpDate = DateTime.now();
  final _inputTitleController = TextEditingController();

  final _inputAmountController = TextEditingController();

  // void submittedExpenses(){
  void _submittedExpenses() {
    //To make sure if amount is empty not to save
    if (_inputAmountController.text.isEmpty) {
      return;
    }
    var expensesTitle = _inputTitleController.text;
    var expensesAmount = double.parse(_inputAmountController.text);
    if (expensesTitle.isEmpty ||
        expensesAmount <= 0 ||
        _chosenExpDate == null) {
      return;
    }
    widget.addExp(expensesTitle, expensesAmount, _chosenExpDate);
    Navigator.of(context).pop();
  }

  void _expensesDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((chosedExpDate) {
      if (_chosenExpDate == null) {
        return;
      }
      setState(() {
        _chosenExpDate = chosedExpDate as DateTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  cursorColor: Colors.blueAccent,
                  cursorWidth: 4,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(fontSize: 18),
                  ),
                  controller: _inputTitleController,
                  onSubmitted: (_) => _submittedExpenses(),
                  // onChanged: (val) => inputTitle=val,
                ),
                TextField(
                  cursorColor: Colors.blueAccent,
                  cursorWidth: 4,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(fontSize: 18),
                  ),
                  controller: _inputAmountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submittedExpenses(),
                  // onChanged: (val) => submittedExpenses,
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_chosenExpDate == null
                          ? 'No date chosen!'
                          : DateFormat.yMd().format(_chosenExpDate)),
                      TextButton(
                        // style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                        onPressed: _expensesDate,
                        child: const Text('Expense Date',
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold)),
                      ),
                    ]),
                TextButton(
                  onPressed: _submittedExpenses,
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
