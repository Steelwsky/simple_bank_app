import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_bank_app/controller/transaction_controller.dart';

class DiagramDonutPieChartPage extends StatefulWidget {
  @override
  _DiagramDonutPieChartPageState createState() => _DiagramDonutPieChartPageState();
}

class _DiagramDonutPieChartPageState extends State<DiagramDonutPieChartPage> {
  List<charts.Series<TypeSummaryData, int>> list;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final TransactionController transactionController = Provider.of<TransactionController>(context);
    list = transactionController.createDonutWithData();
  }

  @override
  Widget build(BuildContext context) {
    // final TransactionController transactionController = Provider.of<TransactionController>(context);
    return Center(
      child: Container(
          child: charts.PieChart(list,
              animationDuration: Duration(milliseconds: 400),
              animate: true,
              defaultRenderer: charts.ArcRendererConfig(arcWidth: 120, arcRendererDecorators: [
                new charts.ArcLabelDecorator(
                    // insideLabelStyleSpec: charts.TextStyleSpec(
                    //     color: charts.Color(r: 42, g: 42, b: 46, a: 1), fontSize: 14),
                    // leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
                    //     color: charts.Color(r: 42, g: 42, b: 46, a: 1)),
                    ),
              ]))),
    );
  }
}
