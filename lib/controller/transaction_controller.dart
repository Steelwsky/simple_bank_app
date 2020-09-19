import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_bank_app/models/transaction.dart';
import 'package:simple_bank_app/storage/storage_concept.dart';
import 'package:uuid/uuid.dart';

class TransactionController {
  TransactionController({@required this.myDatabase});

  final CloudStorage myDatabase;

  final ValueNotifier<List<BankTransaction>> transactionList = ValueNotifier([]);

  String _getUuidFromString() => Uuid().v4();

  Future<void> loadAndSetData() async {
    final List<BankTransaction> _list = await myDatabase.loadTransactions();
    transactionList.value = _list;
  }

  Future<void> cancelTransaction({String transactionId}) async {
    final List<BankTransaction> _list = [];
    _list.addAll(transactionList.value);
    _list.removeWhere((element) => element.id == transactionId);
    transactionList.value = _list;
    await myDatabase.cancelTransaction(transactionId: transactionId);
  }

  Future<void> addTransaction({@required BankTransaction bankTransaction}) async {
    await myDatabase.saveTransaction(bankTransaction: bankTransaction);
  }

  void createTransaction() {
    final List<BankTransaction> _list = [];
    _list.addAll(transactionList.value);

    final number = _randomSum(1000, 2000);
    final fee = number * 5 / 100;

    final randomTransaction = BankTransaction(
      DateTime(2020, 09, 19),
      number,
      fee,
      number + fee,
      _getUuidFromString(),
      _randomType(),
    );

    _list.add(randomTransaction);
    transactionList.value = _list;
    addTransaction(bankTransaction: randomTransaction);
  }

  double _randomSum(double min, double max) {
    final _random = new Random();
    return min + _random.nextInt((max - min).toInt());
  }

  Types _randomType() {
    final max = Types.values.length;
    final _random = new Random();
    return Types.values[_random.nextInt(max)];
  }
}
