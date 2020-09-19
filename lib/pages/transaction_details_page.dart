import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_bank_app/controller/transaction_controller.dart';
import 'package:simple_bank_app/models/transaction.dart';

class TransactionDetailsPage extends StatelessWidget {
  TransactionDetailsPage({@required this.transaction});

  final BankTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController = Provider.of<TransactionController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction ${DateFormat('yyyy-MM-dd').format(transaction.dateTime)}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: [
              Text('${transaction.sum}'),
              Text('${transaction.transactionType.toString().substring(6)}'),
              Text('${transaction.fee}'),
              Text('${transaction.summary}'),
              Text('${transaction.id}'),
              MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: Colors.red,
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  transactionController.cancelTransaction(transactionId: transaction.id);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
