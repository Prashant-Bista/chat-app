import 'package:chat_app/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool makeInvisible = true;

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 28, 70, 1.0),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ChatI",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    fontFamily: "roboto",
                    color: Colors.white,
                  ),
                ),
                Text(
                  "tOut",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    fontFamily: "roboto",
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Container(
                padding: const EdgeInsets.all(1),
                width: widthDevice / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(30, 41, 53, 1),
                ),
                child: TextFormField(

                  obscureText: makeInvisible,
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email cannot be empty";
                    }
                    else
                    return null;
                  },
                  controller: passwordController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          makeInvisible = !makeInvisible;
                        });
                      },
                      icon: Icon(
                        makeInvisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.password),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(30, 41, 53, 1),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(30, 41, 53, 1),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(1),
                    width: widthDevice / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromRGBO(30, 41, 53, 1),
                    ),
                    child: TextFormField(

                      obscureText: makeInvisible,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value.length < 8) {
                          return "Password length should be >= 8";
                        } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return "Please enter at least one uppercase letter [A-Z]";
                        } else if (!RegExp(r'\d').hasMatch(value)) {
                          return "Please enter at least one digit";
                        } else if (!RegExp(
                                r'[!@#$%^&*()_+{}\[\]:;"\<>,.?~\\/-]')
                            .hasMatch(value)) {
                          return "Please enter at least one special character";
                        }
                        return null;
                      },
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              makeInvisible = !makeInvisible;
                            });
                          },
                          icon: Icon(
                            makeInvisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.password),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(30, 41, 53, 1),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(30, 41, 53, 1),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    height: heightDevice / 15,
                    minWidth: widthDevice / 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.deepPurple,
                    splashColor: Colors.deepPurpleAccent,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Process the data
                      } else {
                        // Optionally handle failed validation
                      }
                    },
                    padding: EdgeInsets.zero,
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: widthDevice / 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext Context) => AlertDialog(
                              title: Text("DOne"),
                              content: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.keyboard_return))));
                    },
                    child: const Text("Haven't made an account yet?",
                        style: TextStyle(color: Colors.deepPurple),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
// import 'package:flutter/material.dart';
//
// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   bool makeInvisible = true;
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final double widthDevice = MediaQuery.of(context).size.width;
//     final double heightDevice = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//         body: Center(
//         child: Form(
//         key: formKey,
//         child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//         Container(
//         padding: const EdgeInsets.all(1),
//     width: widthDevice / 1.5,
//     height: 50.0,
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(15),
//     color: const Color.fromRGBO(30, 41, 53, 1),
//     ),
//     child: TextFormField(
//     obscureText: makeInvisible,
//     style: const TextStyle(color: Colors.white),

//   controller: passwordController,
//   textAlign: TextAlign.center,
//   decoration: InputDecoration(
//   suffixIcon: IconButton(
//   onPressed: () {
//   setState(() {
//   makeInvisible = !makeInvisible;
//   });
//   },
//   icon: Icon(
//   makeInvisible ? Icons.visibility_off : Icons.visibility,
//   color: Colors.grey,
//   size: 20,
//   ),
//   ),
//   hintStyle: const TextStyle(color: Colors.grey),
//   hintText: "Password",
//   prefixIcon: const Icon(Icons.password),
//   enabledBorder: OutlineInputBorder(
//   borderRadius: BorderRadius.circular(15),
//   borderSide: const BorderSide(
//   color: Color.fromRGBO(30, 41, 53, 1),
//   width: 1,
//   style: BorderStyle.solid,
//   ),
//   ),
//   focusedBorder: OutlineInputBorder(
//   borderRadius: BorderRadius.circular(15),
//   borderSide: const BorderSide(
//   color: Color.fromRGBO(30, 41, 53, 1),
//   width: 1,
//   style: BorderStyle.solid,
//   ),
//   ),
//   errorBorder: OutlineInputBorder(
//   borderRadius: BorderRadius.circular(15),
//   borderSide: const BorderSide(
//   color: Colors.red,
//   width: 1,
//   style: BorderStyle.solid,
//   ),
//   ),
//   focusedErrorBorder: OutlineInputBorder(
//   borderRadius: BorderRadius.circular(15),
//   borderSide: const BorderSide(
//   color: Colors.redAccent,
//   width: 1,
//   style: BorderStyle.solid,
//   ),
//   ),
//   ),
//   ),
//   ),
//   const SizedBox(height: 20),
//   MaterialButton(
//   height: heightDevice / 15,
//   minWidth: widthDevice / 4,
//   shape: RoundedRectangleBorder(
//   borderRadius: BorderRadius.circular(10),
//   ),
//   color: Colors.deepPurple,
//   splashColor: Colors.deepPurpleAccent,
//   onPressed: () {
//   if (formKey.currentState!.validate()) {
//   // Process the data
//   } else {
//   // Optionally handle failed validation
//   }
//   },
//   padding: EdgeInsets.zero,
//   child: const Text(
//   "Login",
//   style: TextStyle(color: Colors.white),
//   textAlign: TextAlign.center,
//   ),
//   ),
//   ],
//   ),
//   ),
//   ),
//   );
// }
// }
