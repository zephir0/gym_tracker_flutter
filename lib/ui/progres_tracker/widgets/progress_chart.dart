import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';

import '../../../data/models/training_log.dart';

class ProgressChartWidget extends StatefulWidget {
  final List<TrainingLog> progressLogs;

  ProgressChartWidget({required this.progressLogs});

  @override
  _ProgressChartWidgetState createState() => _ProgressChartWidgetState();
}

class _ProgressChartWidgetState extends State<ProgressChartWidget> {
  bool _showHistory = false;
  bool _animateChart = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 30),
        buildChart(),
        SizedBox(height: 8),
        if (_showHistory) buildHistoryRow(),
        SizedBox(height: 16),
        buildShowHistoryButton(),
        SizedBox(height: 8),
        buildAnimateColorsButton(),
      ],
    );
  }

  GestureDetector buildChart() {
    List<FlSpot> dataPoints = generateDataPoints();

    return GestureDetector(
      onTap: toggleChartAnimation,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 300,
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(show: true), // Display legend
            gridData: FlGridData(show: false),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.grey),
            ),
            minX: 0,
            maxX: dataPoints.length.toDouble() - 1,
            minY: 0,
            maxY: getMaxWeight(),
            lineBarsData: [
              // LineChartBarData(
              //   spots: dataPoints,
              //   isCurved: true,
              //   color: _animateChart ? getAnimatedColors() : [Colors.blue],
              //   dotData: FlDotData(show: false),
              //   barWidth: 4,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  List<FlSpot> generateDataPoints() {
    return List.generate(
      widget.progressLogs.length,
      (index) => FlSpot(
        index.toDouble(),
        widget.progressLogs[index].weight.toDouble(),
      ),
    );
  }

  void toggleChartAnimation() {
    setState(() {
      _animateChart = !_animateChart;
    });
  }

  List<Color> getAnimatedColors() {
    return [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];
  }

  double getMaxWeight() {
    double maxWeight = 0;
    for (var log in widget.progressLogs) {
      if (log.weight > maxWeight) {
        maxWeight = log.weight.toDouble();
      }
    }
    return maxWeight;
  }

  Widget buildHistoryRow() {
    List<FlSpot> dataPoints = generateDataPoints();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          dataPoints.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              '${widget.progressLogs[index].weight.toStringAsFixed(2)} kg',
              style: GlobalVariables.fontStyle.copyWith(
                color: Colors.blue,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildShowHistoryButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: toggleShowHistory,
        child: Text(_showHistory ? 'Hide History' : 'Show History'),
      ),
    );
  }

  void toggleShowHistory() {
    setState(() {
      _showHistory = !_showHistory;
    });
  }

  Widget buildAnimateColorsButton() {
    return ElevatedButton(
      onPressed: toggleAnimateColors,
      child: Text(_animateChart ? 'Animate Colors Off' : 'Animate Colors On'),
    );
  }

  void toggleAnimateColors() {
    setState(() {
      _animateChart = !_animateChart;
    });
  }
}
