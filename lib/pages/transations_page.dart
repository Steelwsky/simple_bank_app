import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_bank_app/controller/transaction_controller.dart';
import 'package:simple_bank_app/models/transaction.dart';
import 'package:simple_bank_app/pages/transaction_details_page.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController = Provider.of<TransactionController>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _overallAmount(context: context),
              MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  '+ Add transaction',
                  style: TextStyle(color: Colors.pink),
                ),
                onPressed: () {
                  transactionController.createTransaction();
                },
              )
            ],
          ),
          Divider(),
          Flexible(
            flex: 8,
            child: TransactionsList(),
          ),
        ],
      ),
    );
  }

  Widget _overallAmount({@required BuildContext context}) {
    final TransactionController transactionController = Provider.of<TransactionController>(context);
    return ValueListenableBuilder<List<BankTransaction>>(
      valueListenable: transactionController.transactionList,
      builder: (_, transactionList, __) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Overall: ${transactionController.transactionList.value.length}'),
        );
      },
    );
  }
}

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController = Provider.of<TransactionController>(context);
    return ValueListenableBuilder<List<BankTransaction>>(
        valueListenable: transactionController.transactionList,
        builder: (_, transactionList, __) {
          return ListView(
              key: PageStorageKey('bankTransactions'),
              children: transactionList
                  .map((transaction) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: ListTile(
                          dense: false,
                          leading: Text(
                            '# ${transactionList.indexOf(transaction) + 1}',
                            style: TextStyle(fontSize: 18),
                          ),
                          title: Text(
                            'Sum: \$${transaction.sum} \nFee: \$${transaction.fee}',
                            maxLines: 3,
                          ),
                          subtitle: Text(
                            'No: ${transaction.id.substring(0, 8)}',
                            style: TextStyle(fontSize: 12),
                          ),
                          trailing: Text(
                            '${transaction.transactionType.toString().substring(6)}',
                            style: TextStyle(fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => TransactionDetailsPage(
                                        transaction: transaction,
                                      )),
                            );
                          },
                        ),
                      ))
                  .toList());
        });
  }
}
