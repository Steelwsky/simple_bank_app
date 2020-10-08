import 'package:simple_bank_app/models/transaction.dart';

abstract class TransactionState {}

class TransactionInitial implements TransactionState {}

class TransactionLoading implements TransactionState {}

class TransactionEmpty implements TransactionState {}

class TransactionLoaded implements TransactionState {
  TransactionLoaded(this.bankTransactions);

  final List<BankTransaction> bankTransactions;
}

class TransactionError implements TransactionState {}
