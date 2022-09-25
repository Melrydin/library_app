import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../global.dart';
import 'converter.dart';

class AllPay extends StatefulWidget {
  const AllPay({Key? key, required this.pay}) : super(key: key);

  final double pay;

  @override
  State<AllPay> createState() => _AllPayState();
}

class _AllPayState extends State<AllPay> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        padding: const EdgeInsets.all(5),
        height: 60,
        width: 380,
        decoration: BoxDecoration(
          color: redColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Center(
            child: Text(
          "All Pay: ${widget.pay}€",
          style: darkAllPay,
        )));
  }
}

class YearStatistics extends StatefulWidget {
  const YearStatistics({Key? key, required this.yearPay, required this.year})
      : super(key: key);

  final double yearPay;
  final int year;

  @override
  State<YearStatistics> createState() => _YearStatistics();
}

class _YearStatistics extends State<YearStatistics> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(5),
      height: 105,
      width: 380,
      decoration: BoxDecoration(
        color: redColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text("${widget.year}", style: darkBookTitle),
          Divider(
            height: 10,
            color: darkGreyColor,
          ),
          Text(
            "${widget.yearPay}€/360€",
            style: darkAllPay,
          ),
        ],
      ),
    );
  }
}

class WishOrLibrary extends StatelessWidget {
  final List<ChartData> data;

  const WishOrLibrary({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ChartData, String>> series = [
      charts.Series(
          id: 'Wish',
          data: data,
          domainFn: (ChartData e, _) => e.title,
          measureFn: (ChartData e, _) => e.value,
          colorFn: (ChartData e, _) => e.barColor,
          labelAccessorFn: (ChartData row, _) => '${row.title}: ${row.value}'),
    ];
    return Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        padding: const EdgeInsets.all(5),
        height: 380,
        width: 380,
        decoration: BoxDecoration(
          color: redColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Text("Wish, Library or Gift", style: darkBookTitle),
            Divider(
              height: 10,
              color: darkGreyColor,
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: charts.PieChart(
                series,
                animate: false,
              ),
            ),
          ],
        ));
  }
}
