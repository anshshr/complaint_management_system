import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildPieChart() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
        children: [
          const Text(
            'Most Common Problems',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 300, // Fixed height to prevent overflow
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: 40,
                          color: Colors.blue,
                          radius: 60,
                          title: '40%',
                          titleStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          value: 30,
                          color: Colors.green,
                          radius: 60,
                          title: '30%',
                          titleStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          value: 20,
                          color: Colors.orange,
                          radius: 60,
                          title: '20%',
                          titleStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          value: 10,
                          color: Colors.red,
                          radius: 60,
                          title: '10%',
                          titleStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      sectionsSpace: 2,
                      centerSpaceRadius: 50,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20), // Space between pie chart and legend
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LegendItem(color: Colors.blue, text: 'Train Delay'),
                  LegendItem(color: Colors.green, text: 'Cleanliness'),
                  LegendItem(color: Colors.orange, text: 'Staff Behavior'),
                  LegendItem(color: Colors.red, text: 'Other'),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
