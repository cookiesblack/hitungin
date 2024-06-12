import 'package:flutter/material.dart';
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
      d: json['d'],
      e: json['e'],
      f: json['f'],
      g: json['g'],
    );
  }
}

class DataFetcher {
  static const String url =
      'https://script.google.com/macros/s/AKfycbzbhyRPcO7xytDhIJH6ytECm3YFlsmi8dO0tNOPpPg2Mv7veL0p1sh8Yo6nTKlk97Fj/exec';

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
  late Future<DataResponse> futureData;

  @override
  void initState() {
    super.initState();
    futureData = DataFetcher().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perolehan Suara'),
      ),
      body: FutureBuilder<DataResponse>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
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
                        DataCell(Text('${snapshot.data!.data.d}')),
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
                        DataCell(Text('${snapshot.data!.data.e}')),
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
                        DataCell(Text('${snapshot.data!.data.f}')),
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
                        DataCell(Text('${snapshot.data!.data.g}')),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
