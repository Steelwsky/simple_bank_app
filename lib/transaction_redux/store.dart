import 'package:redux/redux.dart';
import 'package:simple_bank_app/transaction_redux/transaction_state.dart';

Future<Store<TransactionState>> createReduxStore() async {
  return Store<TransactionState>(
    reducer,
    initialState: TransactionEmpty(),
    middleware: [
      // database // database funcs?
    ],
  );
}
