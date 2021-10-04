import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Income extends StatefulWidget {
  const Income({Key? key}) : super(key: key);

  @override
  _IncomeState createState() => _IncomeState();
}

class _IncomeState extends State<Income> {

  List<_IncomeData> data = [
    _IncomeData('Jan', 35),
    _IncomeData('Feb', 28),
    _IncomeData('Mar', 34),
    _IncomeData('Apr', 32),
    _IncomeData('May', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020925),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Income analysis'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_IncomeData, String>>[
                LineSeries<_IncomeData, String>(
                    dataSource: data,
                    xValueMapper: (_IncomeData income, _) => income.year,
                    yValueMapper: (_IncomeData income, _) => income.income,
                    name: 'Income',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true),),
              ],),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     //Initialize the spark charts widget
          //     child: SfSparkLineChart.custom(
          //       //Enable the trackball
          //       trackball: const SparkChartTrackball(
          //           activationMode: SparkChartActivationMode.tap),
          //       //Enable marker
          //       marker: const SparkChartMarker(
          //           displayMode: SparkChartMarkerDisplayMode.all),
          //       //Enable data label
          //       labelDisplayMode: SparkChartLabelDisplayMode.all,
          //       xValueMapper: (int index) => data[index].year,
          //       yValueMapper: (int index) => data[index].sales,
          //       dataCount: 5,
          //     ),
          //   ),
          // )
        ],),
    );
  }
}
class _IncomeData {
  _IncomeData(this.year, this.income);

  final String year;
  final double income;
}