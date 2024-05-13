import 'package:bebek_terminal/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:countup/countup.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:bebek_terminal/games.dart';
import 'package:bebek_terminal/order.dart';
import 'package:bebek_terminal/partner.dart';
import 'package:bebek_terminal/refferal.dart';
// ignore: unused_import
import 'package:connectivity/connectivity.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var response, app;
  String urlaktif = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: HexColor("#EAEAEA"),
      appBar: null,
      body: RefreshIndicator(
          onRefresh: _refreshPage,
          child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/background.png'), // Replace with the path to your image
                  fit: BoxFit.cover,
                ),
              ),
              child: StaggeredGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                staggeredTiles: const [
                  StaggeredTile.extent(2, 10),
                  StaggeredTile.extent(2, 75),
                  StaggeredTile.extent(2, 75),
                  StaggeredTile.extent(2, 120),
                  StaggeredTile.extent(2, 1),
                  StaggeredTile.extent(1, 125),
                  StaggeredTile.extent(1, 50),
                  StaggeredTile.extent(1, 125),
                  StaggeredTile.extent(1, 50),
                  StaggeredTile.extent(1, 125),
                  StaggeredTile.extent(1, 50),
                  StaggeredTile.extent(1, 125),
                  StaggeredTile.extent(1, 50),
                ],
                children: <Widget>[
                  const Divider(
                    color: Color.fromARGB(0, 62, 42, 42),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 75, // Set the width of the box
                      height: 75, // Set the height of the box
                      decoration: BoxDecoration(
                        color: Colors.black12, // Box background color
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20.0), // Same as the container's border radius
                        child: Image.asset('assets/avatar.png',
                            height: 90, fit: BoxFit.fitHeight),
                      ),
                    ),
                  ),

                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Hello, Amalia!',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: HexColor("#000"),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Welcome to Bebek Terminal app.',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: HexColor("#000"),
                                fontSize: 17,
                              ),
                            ),
                          )),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 13),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Colors
                              .grey[800], // Background color of the input field
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(0, 62, 42, 42),
                  ),
                  Material(
                      color: const Color.fromARGB(0, 255, 255, 255),
                      shadowColor: const Color(0x802196F3),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const GamesRoute()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black12, // Box background color
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the border radius
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Same as the container's border radius
                              child: Image.asset('assets/gamepad.png',
                                  height: 90, fit: BoxFit.fitHeight),
                            ),
                          ))),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.black12, // Box background color
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Order in app',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: HexColor("#000"),
                                fontSize: 17,
                              ),
                            ),
                          ))),

                  Material(
                      color: const Color.fromARGB(0, 255, 255, 255),
                      shadowColor: const Color(0x802196F3),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const OrderRoute()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black12, // Box background color
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the border radius
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Same as the container's border radius
                              child: Image.asset('assets/cart.png',
                                  height: 90, fit: BoxFit.fitHeight),
                            ),
                          ))),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black12, // Box background color
                      borderRadius:
                          BorderRadius.circular(20.0), // Set the border radius
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Games in app',
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              color: Colors.black87,
                              fontSize: 17,
                            ),
                          ),
                        )),
                  ),
                  Material(
                      color: const Color.fromARGB(0, 255, 255, 255),
                      shadowColor: const Color(0x802196F3),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const PartnerRoute()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black12, // Box background color
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the border radius
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Same as the container's border radius
                              child: Image.asset('assets/seniman.png',
                                  height: 90, fit: BoxFit.fitHeight),
                            ),
                          ))),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.black12, // Box background color
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Referral Point',
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                              ),
                            ),
                          ))),
                  Material(
                      color: const Color.fromARGB(0, 255, 255, 255),
                      shadowColor: const Color(0x802196F3),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const RefferalRoute()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black12, // Box background color
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the border radius
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Same as the container's border radius
                              child: Image.asset('assets/referal.png',
                                  height: 90, fit: BoxFit.contain),
                            ),
                          ))),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.black12, // Box background color
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Partners of Artist',
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ))),
                  // Add your other Material widgets here as you've shown in your original code
                ],
              ))),
    );
  }

  Future<void> _refreshPage() async {}
}
