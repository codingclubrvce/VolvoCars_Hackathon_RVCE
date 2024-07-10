import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar Chart Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bar Chart Example'),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Placeholder(), // Placeholder for top half of the screen
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2, // Bottom half of the screen
                color: Colors.white,
                child: BarChartExample(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BarChartExample extends StatelessWidget {
  final List<CarData> chartData = [
    CarData('XC90', 105),
    CarData('XC60', 90),
    CarData('XC40', 70),
    CarData('C40', 65),
    CarData('S90', 110),
  ];

  final List<Color> barColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(16.0),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(),
        series: <ChartSeries<CarData, String>>[
          BarSeries<CarData, String>(
            dataSource: chartData,
            xValueMapper: (CarData car, _) => car.carModel,
            yValueMapper: (CarData car, _) => car.leadTime,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            color: Colors.blue, // Default color for bars
            pointColorMapper: (CarData data, _) => _getColor(data.carModel),
          ),
        ],
        plotAreaBorderWidth: 0,
        isTransposed: true,
      ),
    );
  }

  Color _getColor(String carModel) {
    switch (carModel) {
      case 'XC90':
        return barColors[0];
      case 'XC60':
        return barColors[1];
      case 'XC40':
        return barColors[2];
      case 'C40':
        return barColors[3];
      case 'S90':
        return barColors[4];
      default:
        return Colors.grey;
    }
  }
}

class CarData {
  final String carModel;
  final double leadTime;

  CarData(this.carModel, this.leadTime);
}
