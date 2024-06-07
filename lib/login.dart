import 'package:hitungin/myapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hitungin/rekapan.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final user = TextEditingController();
    final pass = TextEditingController();

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 222, 222, 222),
        body: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Image.asset('assets/logo.png',
                        height: 250, fit: BoxFit.cover),
                    const Divider(
                      color: Color.fromARGB(0, 62, 42, 42),
                    ),
                    TextFormField(
                      controller: user,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            Colors.white, // Background color of the textbox
                        hintText: 'Username',
                        hintStyle: const TextStyle(
                            color: Colors.grey), // Hint text color
                        prefixIcon: const Icon(
                          Icons.people,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // No border
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(0, 62, 42, 42),
                    ),
                    TextFormField(
                      controller: pass,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            Colors.white, // Background color of the textbox
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            color: Colors.grey), // Hint text color
                        prefixIcon: const Icon(
                          Icons.key,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // No border
                        ),
                      ),
                      obscureText: true,
                    ),
                    const Divider(
                      color: Color.fromARGB(0, 62, 42, 42),
                    ),
                    const Divider(
                      color: Color.fromARGB(0, 62, 42, 42),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              final username = user.text;
                              final password = pass.text;
                              if (username == 'admin' && password == 'admin') {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => const Myapp()),
                                );
                              } else {
                                // Show an error message or handle login failure
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Login Gagal. Cek Username dan Password.'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .transparent, // Set primary color to transparent
                              elevation: 0,
                            ),
                            child: Container(
                              width: 250,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    HexColor("#89CFF0"),
                                    HexColor("#89CFF0"),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      10.0), // Adjust padding as needed
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(0, 62, 42, 42),
                    ),
                    // Center(
                    //     child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: const <Widget>[
                    //     Text(
                    //       "Daftarkan Akun? ",
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //     SizedBox(height: 8.0),
                    //   ],
                    // )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const Rekapan()),
                          );
                        },
                        child: const Text('Lihat Rekapan',
                            style: TextStyle(
                              color: Colors.amber,
                              decoration: TextDecoration.underline,
                            )))
                  ],
                ),
              ),
            )));
  }
}
