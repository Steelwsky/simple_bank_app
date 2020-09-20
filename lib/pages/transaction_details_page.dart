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
        title: Text(
          'Transaction ${DateFormat('yyyy-MM-dd').format(transaction.dateTime)}',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Operation: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '${transaction.transactionType.toString().substring(6).toUpperCase()}',
                      style: TextStyle(fontSize: 18, color: Colors.pink),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 48,
              ),
              _text(
                textBefore: 'Transaction',
                textAfter: transaction.sum.toString(),
                isMoney: true,
              ),
              SizedBox(
                height: 16,
              ),
              _text(
                textBefore: 'Fee',
                textAfter: transaction.fee.toString(),
                isMoney: true,
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                color: Colors.pink,
                thickness: 2,
              ),
              SizedBox(
                height: 16,
              ),
              _text(
                textBefore: 'Summary',
                textAfter: transaction.summary.toString(),
                isMoney: true,
                isPink: true,
              ),
              SizedBox(
                height: 32,
              ),
              _text(
                textBefore: 'Transaction id',
                textAfter: transaction.id.toString().substring(0, 8),
                isSmall: true,
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: Colors.red,
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    transactionController.cancelTransaction(transactionId: transaction.id);
                    Navigator.pop(context, '${transaction.id.substring(0, 8)}');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _text({
    String textBefore,
    String textAfter,
    bool isMoney,
    bool isPink,
    bool isSmall,
  }) {
    return Row(
      children: <Widget>[
        Text(
          '$textBefore: ',
          style: TextStyle(
            fontSize: isSmall == null || !isSmall ? 18 : 14,
          ),
        ),
        Text(
          isMoney == null || !isMoney ? '' + '$textAfter' : '\$' + '$textAfter',
          style: TextStyle(
            fontSize: isSmall == null || !isSmall ? 18 : 14,
            color: isPink == null || !isPink ? Colors.white : Colors.pink,
          ),
        ),
      ],
    );
  }
}
