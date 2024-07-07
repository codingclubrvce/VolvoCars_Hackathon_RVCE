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
    CarData('Car A', 30),
    CarData('Car B', 25),
    CarData('Car C', 40),
    CarData('Car D', 20),
    CarData('Car E', 35),
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
      case 'Car A':
        return barColors[0];
      case 'Car B':
        return barColors[1];
      case 'Car C':
        return barColors[2];
      case 'Car D':
        return barColors[3];
      case 'Car E':
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
