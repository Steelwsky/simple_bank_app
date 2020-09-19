import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_bank_app/models/transaction.dart';
import 'package:simple_bank_app/storage/storage_concept.dart';
import 'package:uuid/uuid.dart';

class TransactionController {
  TransactionController({@required this.myDatabase}) {
    loadAndSetData();
  }

  final CloudStorage myDatabase;

  final ValueNotifier<AsyncSnapshot<List<BankTransaction>>> transactionList =
      ValueNotifier(AsyncSnapshot.withData(ConnectionState.none, null));

  String _getUuidFromString() => Uuid().v4();

  Future<bool> loadAndSetData() async {
    final List<BankTransaction> _list = await myDatabase.loadTransactions();
    transactionList.value = AsyncSnapshot.withData(ConnectionState.done, _list);
    return true;
  }

  Future<void> cancelTransaction({String transactionId}) async {
    final List<BankTransaction> _list = [];
    _list.addAll(transactionList.value.data);
    _list.removeWhere((element) => element.id == transactionId);
    transactionList.value = AsyncSnapshot.withData(ConnectionState.done, _list);
    await myDatabase.cancelTransaction(transactionId: transactionId);
  }

  Future<void> addTransaction({@required BankTransaction bankTransaction}) async {
    await myDatabase.saveTransaction(bankTransaction: bankTransaction);
  }

  void createTransaction() {
    final List<BankTransaction> _list = [];
    _list.addAll(transactionList.value.data);

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
    transactionList.value = AsyncSnapshot.withData(ConnectionState.done, _list);
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

  String _nameByKey(int key) {
    return Types.values[key].toString().substring(6);
  }

  List<charts.Series<TypeSummaryData, int>> createDonutWithData() {
    List<TypeSummaryData> countTypes = [];
    for (var element in transactionList.value.data) {
      countTypes.add(TypeSummaryData(
        index: element.transactionType.index,
        name: element.transactionType.toString().substring(6),
        summary: element.summary.toInt(),
      ));
    }

    Map<int, int> newTypeSummary = {};
    for (var elem in countTypes) {
      if (newTypeSummary.containsKey(elem.index)) {
        newTypeSummary.update(elem.index, (value) => value + elem.summary);
        print(
            '*** contains key: ${elem.index}, sum: ${elem.summary} summary: ${newTypeSummary[elem.index]}');
      } else {
        newTypeSummary[elem.index] = elem.summary;
        print(
            '### NOT contains key: ${elem.index}, sum: ${elem.summary}, summary: ${newTypeSummary[elem.index]}');
      }
    }
    print(newTypeSummary);

    countTypes = [];
    newTypeSummary.forEach((key, value) {
      countTypes.add(TypeSummaryData(index: key, name: _nameByKey(key), summary: value));
    });

    return [
      new charts.Series<TypeSummaryData, int>(
        id: 'Types',
        data: countTypes,
        domainFn: (TypeSummaryData bankTransaction, _) => bankTransaction.index,
        measureFn: (TypeSummaryData bankTransaction, _) => bankTransaction.summary,
        labelAccessorFn: (TypeSummaryData row, _) => '${row.name}\n\$${row.summary}',
      )
    ];
  }
}

class TypeSummaryData {
  TypeSummaryData({this.index, this.name, this.summary});

  final int index;
  final String name;
  final int summary;
}
