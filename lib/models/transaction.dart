import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum Types {
  addition,
  transition,
  withdrawal,
}

DateTime timestampHelper({@required Timestamp timestamp}) {
  return timestamp.toDate();
}

Types toType({String type}) {
  if (type == 'addition') {
    return Types.addition;
  } else if (type == 'transition') {
    return Types.transition;
  } else {
    return Types.withdrawal;
  }
}

class BankTransaction {
  BankTransaction(this.dateTime, this.sum, this.fee, this.summary, this.id, this.transactionType);

  final String id;
  final DateTime dateTime;
  final double sum;
  final double fee;
  final double summary;
  final Types transactionType;

  BankTransaction.fromJson(Map<String, dynamic> json)
      : id = json['id'] != null ? json['id'] : '',
        dateTime = json['dateTime'] != null ? timestampHelper(timestamp: json['dateTime']) : '',
        sum = json['sum'] != null ? json['sum'] : '',
        fee = json['fee'],
        summary = json['summary'],
        transactionType = toType(type: json['transactionType']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTime': dateTime,
      'sum': sum,
      'fee': fee,
      'summary': summary,
      'transactionType': transactionType.toString().substring(6),
    };
  }
}
