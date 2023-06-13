import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:library_app/UI/NavigationWidget.dart';

import 'package:library_app/models/widgets/statisticCards.dart';
import 'package:library_app/models/global.dart';
import 'package:library_app/models/widgets/converter.dart';

import 'package:library_app/networking.dart';



class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPage();
}

class _StatisticsPage extends State<StatisticsPage> {
  bool isLoading = false;
  double allPay = 0.0;
  List<int> years = [];
  List<double> yearsPay = [];
  List<ChartData> wishOrLibrary = [];

  @override
  void initState() {
    super.initState();

    refreshStatistics();
  }

  Future refreshStatistics() async {
    setState(() {
      isLoading = true;
    });

    allPay = await networking.allPay();
    years = await networking.years();
    for (int i = 0; i < years.length; i++) {
      yearsPay.add(await networking.yearPay(years[i]));
    }
    List<int> trueOrFalse = await networking.wishOrLibrary();
    wishOrLibrary = [
      ChartData(
          title: "Wishlist",
          value: trueOrFalse[0],
          barColor: charts.ColorUtil.fromDartColor(Colors.green)),
      ChartData(
          title: "Library",
          value: trueOrFalse[1],
          barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
      ChartData(
          title: "Gift",
          value: trueOrFalse[2],
          barColor: charts.ColorUtil.fromDartColor(Colors.grey))
    ];

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreyColor,
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: darkGreyColor,
        title: const Text("Statistics"),
      ),
      body: Container(
        color: darkGreyColor,
        child: Center(
          child: Column(
            children: [
              Container(
                color: darkGreyColor,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Column(
                        children: [
                          AllPay(
                            pay: allPay,
                          ),
                          SizedBox(
                            height: 115,
                            child: ListView.builder(
                              itemCount: years.length,
                              itemBuilder: (context, index) {
                                return YearStatistics(
                                  yearPay: yearsPay[index],
                                  year: years[index],
                                );
                              },
                            ),
                          ),
                          WishOrLibrary(data: wishOrLibrary),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
