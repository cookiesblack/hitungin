import 'package:bebek_terminal/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registration'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset('assets/logo.png', height: 300, fit: BoxFit.cover),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Refferal Code'),
                  obscureText: true,
                ),
                const Divider(
                  color: Color.fromARGB(0, 62, 42, 42),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity, // Make the button full width
                        child: ElevatedButton(
                          onPressed: () async {
                            await Alert(
                              context: context,
                              type: AlertType.info,
                              title: "Alert",
                              desc: "Registration Success",
                              style: const AlertStyle(
                                  animationType: AnimationType.grow,
                                  isCloseButton: false),
                              buttons: [
                                DialogButton(
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )
                              ],
                            ).show();

                            // Navigator.push(
                            //   context,
                            //   CupertinoPageRoute(
                            //       builder: (context) => Dashboard()),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30.0), // Set the border radius
                            ),
                          ),
                          child: const Text('Register'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
