import 'package:exp/main.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  var summary = HomePage.summary;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildList(),
    );
  }

  Widget _buildList() {
    var allExp = summary.getAllExpenses();
    return ListView.builder(
      itemCount: allExp.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(allExp[index].amount.toString()),
          subtitle: Text(allExp[index].type + ' | '+ allExp[index].date),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                summary.removeExpense(allExp[index]);
              });
            },
          ),
        );
      },
    );
  }
}
