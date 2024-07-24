import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataResponse {
  String status;
  Data data;

  DataResponse({required this.status, required this.data});

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    return DataResponse(
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  int d;
  int e;
  int f;
  int g;

  Data({required this.d, required this.e, required this.f, required this.g});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      d: parseInt(json['d']),
      e: parseInt(json['e']),
      f: parseInt(json['f']),
      g: parseInt(json['g']),
    );
  }

  static int parseInt(dynamic value) {
    return value is int ? value : 0;
  }
}

class DataFetcher {
  static const String url =
      'https://script.google.com/macros/s/AKfycbyah5VP_HE--qeK9DJsm8x2Ra4CrF7JIflfCrIksnKq6NAIWr3t_z1NsxElct3UFgC2/exec';

  Future<DataResponse> fetchData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return DataResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class UrutanSuara extends StatefulWidget {
  const UrutanSuara({super.key});

  @override
  _UrutanSuaraState createState() => _UrutanSuaraState();
}

class _UrutanSuaraState extends State<UrutanSuara> {
  Data? currentData;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchData(); // Initial data fetch

    // Set up a timer to fetch data every 5 seconds
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      fetchData();
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final response = await DataFetcher().fetchData();
      setState(() {
        currentData = response.data;
      });
    } catch (error) {
      // Handle the error (log it, show a message, etc.)
      debugPrint('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perolehan Suara'),
      ),
      body: currentData != null
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10.0),
                child: DataTable(
                  border: TableBorder.symmetric(
                    outside: BorderSide.none,
                    inside: BorderSide.none,
                  ),
                  dataRowHeight: 200.0,
                  columns: const [
                    DataColumn(label: Text('')),
                    DataColumn(label: Text('Total Suara')),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(SizedBox(
                          width: 130,
                          height: 500,
                          child: Image.asset(
                            'assets/1.png',
                            fit: BoxFit.fill,
                          ),
                        )),
                        DataCell(Text('${currentData!.d}')),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(SizedBox(
                          width: 130,
                          height: 500,
                          child: Image.asset(
                            'assets/2.png',
                            fit: BoxFit.fill,
                          ),
                        )),
                        DataCell(Text('${currentData!.e}')),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(SizedBox(
                          width: 130,
                          height: 500,
                          child: Image.asset(
                            'assets/3.png',
                            fit: BoxFit.fill,
                          ),
                        )),
                        DataCell(Text('${currentData!.f}')),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(SizedBox(
                          width: 130,
                          height: 500,
                          child: Image.asset(
                            'assets/4.png',
                            fit: BoxFit.fill,
                          ),
                        )),
                        DataCell(Text('${currentData!.g}')),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
