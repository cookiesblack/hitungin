import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class RefferalRoute extends StatelessWidget {
  const RefferalRoute({super.key});

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
                      'Referral Point',
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
                  child: Image.asset('assets/referral.png',
                      height: 300, fit: BoxFit.cover),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                          'Invite your friends to play and get points every time you recommend the Bebek Terminal application.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: HexColor("#000"),
                              fontSize: 17,
                            ),
                          ),
                        ))),
              ],
            )));
  }
}
