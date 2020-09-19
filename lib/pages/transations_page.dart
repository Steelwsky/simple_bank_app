import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_bank_app/controller/transaction_controller.dart';
import 'package:simple_bank_app/models/transaction.dart';
import 'package:simple_bank_app/pages/transaction_details_page.dart';
import 'package:simple_bank_app/widgets/circular_loader.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController = Provider.of<TransactionController>(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 16.0,
        right: 16.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _overallAmount(context: context),
                MaterialButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: InkWell(
                    child: Row(children: [
                      Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.pink,
                      ),
                      Text(
                        'Add transaction',
                        style: TextStyle(color: Colors.pink, fontSize: 16),
                      ),
                    ]),
                  ),
                  onPressed: () {
                    transactionController.createTransaction();
                  },
                )
              ],
            ),
          ),
          Divider(),
          Flexible(
            flex: 9,
            child: TransactionsBlock(),
          ),
        ],
      ),
    );
  }

  Widget _overallAmount({@required BuildContext context}) {
    final TransactionController transactionController = Provider.of<TransactionController>(context);
    return ValueListenableBuilder<AsyncSnapshot<List<BankTransaction>>>(
      valueListenable: transactionController.transactionList,
      builder: (_, snapshot, __) {
        if (snapshot.hasData && snapshot.data != null) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Overall: ${snapshot.data.length}',
              style: TextStyle(fontSize: 16),
            ),
          );
        } else
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Overall: loading...'),
          );
      },
    );
  }
}

class TransactionsBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController = Provider.of<TransactionController>(context);
    return ValueListenableBuilder<AsyncSnapshot<List<BankTransaction>>>(
        valueListenable: transactionController.transactionList,
        builder: (_, snapshot, __) {
          if (snapshot.hasData && snapshot.data != null) {
            return TransactionList(snapshot: snapshot);
          }
          return MyCircularIndicatorWidget();
        });
  }
}

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key key,
    @required this.snapshot,
  }) : super(key: key);
  final AsyncSnapshot<List<BankTransaction>> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView(
        key: PageStorageKey('bankTransactions'),
        children: snapshot.data
            .map((transaction) => Card(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    dense: false,
                    leading: Text(
                      '# ${snapshot.data.indexOf(transaction) + 1}',
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
  }
}
