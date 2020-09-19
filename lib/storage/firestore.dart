import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_bank_app/models/transaction.dart';

class FirestoreDatabase {
  final databaseFirestore = FirebaseFirestore.instance;

  Future<void> addTransaction({@required BankTransaction bankTransaction}) async {
    databaseFirestore
        .collection('bankTransactions')
        .doc('${bankTransaction.id}')
        .set(bankTransaction.toJson());
  }

  Future<void> cancelTransaction({@required String transactionId}) async {
    try {
      await databaseFirestore.collection('bankTransactions').doc('$transactionId').delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List<BankTransaction>> retrieveBankTransactions() async {
    try {
      final Iterable<BankTransaction> _list = await databaseFirestore
          .collection('bankTransactions')
          .get()
          .then((value) => value.docs.map((e) => BankTransaction.fromJson(e.data())).toList());
      return _list;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
