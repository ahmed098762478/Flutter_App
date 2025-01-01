import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoChartScreen extends StatefulWidget {
  const CryptoChartScreen({super.key});

  @override
  _CryptoChartScreenState createState() => _CryptoChartScreenState();
}

class _CryptoChartScreenState extends State<CryptoChartScreen> {
  late List<CandleStickData> _chartData;
  late ZoomPanBehavior _zoomPanBehavior;
  late Timer _timer;

  @override
  void initState() {
    _chartData = _getInitialChartData();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      zoomMode: ZoomMode.xy,  
      enableDoubleTapZooming: true,
      enableMouseWheelZooming: true,
    );

     _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() {
        _addDynamicData();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Crypto Chart',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               const Text(
                'EUR/USD - 1.03433',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
               Expanded(
                child: SfCartesianChart(
                  zoomPanBehavior: _zoomPanBehavior,
                  primaryXAxis: CategoryAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    labelStyle: const TextStyle(color: Colors.white),
                    interval: 1, // Intervalle entre les labels
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    labelStyle: const TextStyle(color: Colors.white),
                    majorGridLines: MajorGridLines(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  series: <CandleSeries<CandleStickData, String>>[
                    CandleSeries<CandleStickData, String>(
                      dataSource: _chartData,
                      xValueMapper: (CandleStickData data, _) => data.date,
                      lowValueMapper: (CandleStickData data, _) => data.low,
                      highValueMapper: (CandleStickData data, _) => data.high,
                      openValueMapper: (CandleStickData data, _) => data.open,
                      closeValueMapper: (CandleStickData data, _) => data.close,
                      bearColor: Colors.red,
                      bullColor: Colors.green,
                      width: 0.3,
                      borderWidth: 0.5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTimeButton('1D'),
                  _buildTimeButton('5D'),
                  _buildTimeButton('1M'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeButton(String title) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[800],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  List<CandleStickData> _getInitialChartData() {
    return [
      CandleStickData(date: '19:30', open: 1.034, high: 1.038, low: 1.030, close: 1.036),
      CandleStickData(date: '19:45', open: 1.036, high: 1.041, low: 1.033, close: 1.035),
      CandleStickData(date: '20:00', open: 1.035, high: 1.039, low: 1.032, close: 1.034),
      CandleStickData(date: '20:15', open: 1.034, high: 1.037, low: 1.031, close: 1.032),
      CandleStickData(date: '20:30', open: 1.032, high: 1.036, low: 1.030, close: 1.033),
    ];
  }

  void _addDynamicData() {
    final lastData = _chartData.last;

     final isLastBullish = lastData.close > lastData.open;

    final newOpen = lastData.close;
    final newClose = isLastBullish
        ? newOpen - 0.002  
        : newOpen + 0.002;  

    final newData = CandleStickData(
      date: _getNextTime(lastData.date),
      open: newOpen,
      high: newClose + 0.003,
      low: newClose - 0.003,
      close: newClose,
    );

    _chartData.add(newData);

    if (_chartData.length > 20) {
       _chartData.removeAt(0);
    }
  }

  String _getNextTime(String lastTime) {
    final parts = lastTime.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final newMinute = (minute + 15) % 60;
    final newHour = hour + (minute + 15) ~/ 60;

    return '${newHour.toString().padLeft(2, '0')}:${newMinute.toString().padLeft(2, '0')}';
  }
}

class CandleStickData {
  final String date;
  final double open;
  final double high;
  final double low;
  final double close;

  CandleStickData({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 18, 36)  
      ..style = PaintingStyle.fill;

     canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Dessiner les carrés
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    const squareSize = 50.0;
    for (double x = 0; x < size.width; x += squareSize) {
      for (double y = 0; y < size.height; y += squareSize) {
        canvas.drawRect(Rect.fromLTWH(x, y, squareSize, squareSize), gridPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
