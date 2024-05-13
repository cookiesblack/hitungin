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

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController petugas = TextEditingController();
  final TextEditingController tps = TextEditingController();
  final TextEditingController paslon1 = TextEditingController();
  final TextEditingController paslon2 = TextEditingController();
  final TextEditingController paslon3 = TextEditingController();
  final TextEditingController felmy = TextEditingController();

  late List<Item> kecamatanItems = [];
  late List<Item> kelurahanItems = [];

  var idKecamatan = "7171010";
  var namaKecamatan = "";
  var idKelurahan = "";
  var namaKelurahan = "";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadKecamatan(context);
  }

  Future<void> _submitForm() async {
    const String scriptURL =
        'https://script.google.com/macros/s/AKfycbwNpIgxW9eFdX_fXLAEU49fjWys4rGaLZ6C5Y9W2O_iUOfiM0J90TKXqDBikKck6tVi_g/exec';
    String a = namaKecamatan;
    String b = namaKelurahan;
    String c = tps.text;
    String d = paslon1.text;
    String e = paslon2.text;
    String f = paslon3.text;
    String g = felmy.text;
    String h = petugas.text;
    // String g = petugas.text;

    String queryString =
        "?kecamatan=$a&desa=$b&tps=$c&paslon1=$d&paslon2=$e&paslon3=$f&felmy=$g&petugas=$h";

    var finalURI = Uri.parse(scriptURL + queryString);

    print(scriptURL + queryString);
    log(scriptURL + queryString);
    setState(() {
      isLoading = true;
    });
    var response = await http.get(finalURI);
    if (response.statusCode == 200) {
      // var bodyR = jsonDecode(response.body);
      setState(() {
        isLoading = false;
      });
      Alert(
        context: context,
        type: AlertType.info,
        title: "Informasi",
        desc: "Data Berhasil Disimpan",
        style: const AlertStyle(
          animationType: AnimationType.fromTop,
          isCloseButton: false,
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            width: 120,
            child: const Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
      petugas.text = '';
      tps.text = '';
      paslon1.text = '';
      paslon2.text = '';
      paslon3.text = '';
      felmy.text = '';
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0), // Adjust the value as needed
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/background.png'), // Replace with the path to your image
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const Divider(
                  color: Colors.white,
                ),
                Image.asset('assets/pemilu.png',
                    width: 1000, fit: BoxFit.fitWidth),
                const Divider(
                  color: Colors.white,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Hitungin Pemilu 2024',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: HexColor("#555555"),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
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
                TextFormField(
                  controller: tps,
                  decoration: const InputDecoration(labelText: 'TPS'),
                  // textCapitalization: TextCapitalization.characters,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                TextFormField(
                  controller: paslon1,
                  decoration: const InputDecoration(labelText: 'Paslon No. 1'),
                  maxLength: 4,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                if (isLoading) const CircularProgressIndicator(),
                TextFormField(
                  controller: paslon2,
                  decoration: const InputDecoration(labelText: 'Paslon No. 2'),
                  maxLength: 4,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                TextFormField(
                  controller: paslon3,
                  decoration: const InputDecoration(labelText: 'Paslon No. 3'),
                  maxLength: 4,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                TextFormField(
                  controller: felmy,
                  decoration: const InputDecoration(
                      labelText: 'Felmy Rindengan Pelleng'),
                  maxLength: 4,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                TextFormField(
                  controller: petugas,
                  decoration: const InputDecoration(labelText: 'Nama Petugas'),
                  textCapitalization: TextCapitalization.characters,
                ),
                const Divider(
                  color: Colors.white,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (tps.text == "") {
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: "Error",
                                desc: "Lengkapi data sebelum mengirim!",
                                style: const AlertStyle(
                                  animationType: AnimationType.fromTop,
                                  isCloseButton: false,
                                ),
                                buttons: [
                                  DialogButton(
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                    child: const Text(
                                      "Ok",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                ],
                              ).show();
                            } else {
                              // await _submitForm();
                              if (!isLoading) {
                                await _submitForm();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text('Simpan Data'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
        /*
        Positioned(
            bottom: -30,
            right: -10,
            child: GestureDetector(
              onTap: () {
                Alert(
                  context: context,
                  type: AlertType.info,
                  title: "Informasi",
                  desc: "Pendaftaran App by @ewinrizal",
                  style: const AlertStyle(
                    animationType: AnimationType.fromTop,
                    isCloseButton: false,
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                      child: const Text(
                        "Ok",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ).show();
              },
              // child: Image.asset(
              //   'assets/felmy.png',
              //   width: MediaQuery.of(context).size.width + 20,
              //   fit: BoxFit.cover,
              // ),
            )),
      */
      ],
    );
  }
}
