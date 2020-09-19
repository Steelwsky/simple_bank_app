import 'package:flutter/material.dart';
import 'package:simple_bank_app/models/transaction.dart';
import 'package:simple_bank_app/storage/firestore.dart';

typedef LoadTransactions = Future<List<BankTransaction>> Function();

typedef SaveTransaction = Future<void> Function({@required BankTransaction bankTransaction});

typedef CancelTransaction = Future<void> Function({@required String transactionId});

abstract class CloudStorage {
  CloudStorage({
    @required this.loadTransactions,
    @required this.saveTransaction,
    @required this.cancelTransaction,
  });

  final LoadTransactions loadTransactions;
  final SaveTransaction saveTransaction;
  final CancelTransaction cancelTransaction;
}

class MyDatabase implements CloudStorage {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  @override
  LoadTransactions get loadTransactions => firestoreDatabase.retrieveBankTransactions;

  @override
  SaveTransaction get saveTransaction => firestoreDatabase.addTransaction;

  @override
  CancelTransaction get cancelTransaction => firestoreDatabase.cancelTransaction;
}
