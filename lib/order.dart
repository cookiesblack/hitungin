import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class OrderRoute extends StatelessWidget {
  const OrderRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: const Color.fromARGB(0, 255, 255, 255),
        shadowColor: const Color(0x802196F3),
        child: CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Vertically center the children
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Order in App',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: HexColor("#000"),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                Center(
                  child: Image.asset('assets/comingsoon.png',
                      height: 300, fit: BoxFit.cover),
                ),
              ],
            )));
  }
}
