import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../helpers/database_helper.dart';
import '../Represent/api_service.dart';

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
    super.initState();
    _chartData = [];
    _loadSavedData();  
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
                'BTC/USD - Live Data',
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
                    title: AxisTitle(
                      text: "Time (HH:mm)",
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    majorGridLines: const MajorGridLines(width: 0),
                    labelStyle: const TextStyle(color: Colors.white),
                    interval: 1,
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(
                      text: "Price (USD)",
                      textStyle: const TextStyle(color: Colors.white),
                    ),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loadSavedData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Text(
                  'Load Saved Data',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
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

  Future<void> _addDynamicData() async {
    final apiService = ApiService();
    final cryptoData = await apiService.fetchCryptoPrice('BTC');

    if (cryptoData != null) {
      final price = cryptoData['quote']['USD']['price'];
      final lastData = _chartData.isNotEmpty ? _chartData.last : null;

      final newData = CandleStickData(
        date: lastData != null ? _getNextTime(lastData.date) : _getInitialTime(),
        open: lastData?.close ?? price,
        high: price + 0.005,
        low: price - 0.005,
        close: price,
      );

      setState(() {
        _chartData.add(newData);
        if (_chartData.length > 50) {
          _chartData.removeAt(0);
        }
      });

      final dbHelper = DatabaseHelper();
      await dbHelper.insertCryptoPrice(newData);
    }
  }

  Future<void> _loadSavedData() async {
    final dbHelper = DatabaseHelper();
    final savedData = await dbHelper.getSavedCryptoPrices();

    setState(() {
      _chartData = savedData.map((e) {
        return CandleStickData(
          date: e['date'],
          open: e['open'],
          high: e['high'],
          low: e['low'],
          close: e['close'],
        );
      }).toList();
    });
  }

  String _getNextTime(String lastTime) {
    final parts = lastTime.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final newMinute = (minute + 15) % 60;
    final newHour = hour + (minute + 15) ~/ 60;

    return '${newHour.toString().padLeft(2, '0')}:${newMinute.toString().padLeft(2, '0')}';
  }

  String _getInitialTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
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

 