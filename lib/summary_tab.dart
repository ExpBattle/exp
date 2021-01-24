import 'package:exp/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytextformfield/moneytextformfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'Expense.dart';
import 'Summary.dart';

class SummaryTab extends StatefulWidget {
  @override
  _SummaryTabState createState() => _SummaryTabState();
}

class _SummaryTabState extends State<SummaryTab> {
  var summary = HomePage.summary;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4),
        child: Center(
          child: Row(
            children: [
              _buildTotalExp(),
            ],
          ),
        ));
  }

  Widget _buildTotalExp() {
    return Column(
      children: [
        Text(
          summary.getTotalExpenses().toString(),
          style: TextStyle(fontSize: 75),
        ),
        IconButton(
          iconSize: 50,
          color: Colors.lightBlue[800],
          icon: Icon(Icons.add_circle),
          onPressed: () {
            setState(() {
              _pushAdd();
            });
          },
        ),
        summary.buildChart(),
        /*IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            setState(() {});
          },
        )*/
      ],
    );
  }

  void _pushAdd() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add new expense'),
        ),
        body: _addForm(),
      );
    }));
  }

  Widget _addForm() {
    final _formKey = GlobalKey<FormState>();
    final _amountController = TextEditingController();
    final _dateController = TextEditingController();
    var expense = Expense();
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MoneyTextFormField(
              settings: MoneyTextFormFieldSettings(
                validator: (value) {
                  if (value.isEmpty || double.parse(value) <= 0.0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
                controller: _amountController,
              ),
            ),
            DropdownButtonFormField<String>(
              items:
                  expense.possibleTypes.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              icon: Icon(Icons.arrow_downward),
              onChanged: (newValue) {
                setState(() {
                  expense.type = newValue;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a type';
                }
                return null;
              },
            ),
            DateTimeField(
              format: DateFormat("dd-MM-yyyy"),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a date';
                }
                return null;
              },
              controller: _dateController,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  expense.amount = double.parse(_amountController.text);
                  expense.date = _dateController.text;
                  summary.addExpense(expense);
                  Navigator.pop(context);
                  setState(() {});
                }
              },
              child: Text('Submit'),
            )
          ],
        ));
  }
}
