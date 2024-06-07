import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';

class Item {
  final String value;
  final String label;

  Item({required this.value, required this.label});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(value: json['id'], label: json['nama']);
  }
}

String getLabelById(List<Item> items, String id) {
  for (var item in items) {
    if (item.value == id) {
      return item.label;
    }
  }
  // Return some default value or handle the case when the ID is not found.
  return 'Label not found';
}

class Rekapan extends StatefulWidget {
  const Rekapan({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class DataResponse {
  final String status;
  final String idData;
  final List<Data> data;

  DataResponse(
      {required this.status, required this.idData, required this.data});

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return DataResponse(
      status: json['status'],
      idData: json['id_data'],
      data: dataList,
    );
  }
}

class Data {
  final String kecamatan;
  final String desa;
  final int tps;
  final int paslon1;
  final int paslon2;
  final int paslon3;
  final int felmy;
  final String petugas;
  final DateTime createdAt;

  Data({
    required this.kecamatan,
    required this.desa,
    required this.tps,
    required this.paslon1,
    required this.paslon2,
    required this.paslon3,
    required this.felmy,
    required this.petugas,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      kecamatan: json['Kecamatan'],
      desa: json['Desa'],
      tps: json['TPS'],
      paslon1: json['Paslon 1'],
      paslon2: json['Paslon 2'],
      paslon3: json['Paslon 3'],
      felmy: json['Felmy'],
      petugas: json['Petugas'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class _AppState extends State<Rekapan> {
  final TextEditingController petugas = TextEditingController();
  final TextEditingController tps = TextEditingController();
  final TextEditingController paslon1 = TextEditingController();
  final TextEditingController paslon2 = TextEditingController();
  final TextEditingController paslon3 = TextEditingController();
  final TextEditingController felmy = TextEditingController();
  late Future<DataResponse> futureData;

  late List<Item> kecamatanItems = [];
  late List<Item> kelurahanItems = [];

  var idKecamatan = "7171010";
  var namaKecamatan = "";
  var idKelurahan = "";
  var namaKelurahan = "MALALAYANG II";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
    loadKecamatan(context);
  }

  Future<DataResponse> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://script.google.com/macros/s/AKfycbywmMNkJvtKfc0IkUJGMqb1aL7jvZCph2SoDT0Qu0Gzxn3t3SCxO9EVZq5qsQE_fHxQ/exec?desa=$namaKelurahan'));

    if (response.statusCode == 200) {
      return DataResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> loadKecamatan(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/kecamatan.json');

    List<dynamic> jsonList = json.decode(data);
    kecamatanItems = jsonList.map((json) => Item.fromJson(json)).toList();

    setState(() {
      idKecamatan = kecamatanItems.isNotEmpty ? kecamatanItems[0].value : "";
      namaKecamatan = kecamatanItems.isNotEmpty ? kecamatanItems[0].label : "";
      loadKelurahan(context);
    });
  }

  Future<void> loadKelurahan(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/$idKecamatan.json");

    List<dynamic> jsonList = json.decode(data);
    kelurahanItems = jsonList.map((json) => Item.fromJson(json)).toList();

    setState(() {
      idKelurahan = kelurahanItems.isNotEmpty ? kelurahanItems[0].value : "";
      namaKelurahan = kelurahanItems.isNotEmpty ? kelurahanItems[0].label : "";
    });
  }

  Future<void> _submitForm() async {
    setState(() {
      isLoading = true;
    });

    try {
      final newData = await fetchData();
      setState(() {
        futureData = Future.value(newData);
      });
    } catch (e) {
      // Handle error
      print('Failed to submit form: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const Divider(color: Colors.white),
                Image.asset('assets/pemilu.png',
                    width: 1000, fit: BoxFit.fitWidth),
                const Divider(color: Colors.white),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Rekapan Pemilu 2024',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: HexColor("#555555"),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(color: Colors.white),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kecamatan',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 100, 100, 100),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton<String>(
                          value: idKecamatan,
                          onChanged: (String? newValue) {
                            setState(() {
                              idKecamatan = newValue!;
                              namaKecamatan =
                                  getLabelById(kecamatanItems, newValue);
                              loadKelurahan(context);
                            });
                          },
                          items: kecamatanItems.map((Item item) {
                            return DropdownMenuItem<String>(
                              value: item.value,
                              child: Text(item.label),
                            );
                          }).toList(),
                          isExpanded: true,
                        ),
                      ),
                    ),
                    const Text(
                      'Kelurahan',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 100, 100, 100),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton<String>(
                          value: idKelurahan,
                          onChanged: (String? newValue) {
                            setState(() {
                              idKelurahan = newValue!;
                              namaKelurahan =
                                  getLabelById(kelurahanItems, newValue);
                            });
                          },
                          items: kelurahanItems.map((Item item) {
                            return DropdownMenuItem<String>(
                              value: item.value,
                              child: Text(item.label),
                            );
                          }).toList(),
                          isExpanded: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: isLoading
                              ? CircularProgressIndicator()
                              : const Text('Filter'),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white),
                Center(
                  child: FutureBuilder<DataResponse>(
                    future: futureData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Kecamatan')),
                              DataColumn(label: Text('Desa')),
                              DataColumn(label: Text('TPS')),
                              DataColumn(label: Text('Paslon 1')),
                              DataColumn(label: Text('Paslon 2')),
                              DataColumn(label: Text('Paslon 3')),
                              DataColumn(label: Text('Felmy')),
                              DataColumn(label: Text('Petugas')),
                              DataColumn(label: Text('Created At')),
                            ],
                            rows: snapshot.data!.data.map((data) {
                              return DataRow(cells: [
                                DataCell(Text(data.kecamatan)),
                                DataCell(Text(data.desa)),
                                DataCell(Text(data.tps.toString())),
                                DataCell(Text(data.paslon1.toString())),
                                DataCell(Text(data.paslon2.toString())),
                                DataCell(Text(data.paslon3.toString())),
                                DataCell(Text(data.felmy.toString())),
                                DataCell(Text(data.petugas)),
                                DataCell(
                                    Text(data.createdAt.toIso8601String())),
                              ]);
                            }).toList(),
                          ),
                        );
                      } else {
                        return Text('No data available');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
