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

  @override
  Widget build(BuildContext context) {
    double widthDevice= MediaQuery.of(context).size.width;
    double heightDevice= MediaQuery.of(context).size.height;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 28, 70, 1.0),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
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
              ),Text(
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

          SizedBox(height: 50,),
          Form(
              child: Column(
            key: formKey,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: widthDevice/1.5,
                child: Container(
                  padding: EdgeInsets.only(top: 1,right: 1,left: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color.fromRGBO(30, 41, 53, 1)
                  ),
                  child: TextFormField(
                    validator: (value){
                      if (emailController.text.toString().length==0){
                        return "Please Enter Email";
                      }
                      else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value.toString())){
                        return "Enter a Valid Email";
                      }
                    },
                    controller: emailController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email,size: 20,color: Colors.grey,),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                                style: BorderStyle.solid)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                              style: BorderStyle.solid)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 1,
                              style: BorderStyle.solid)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.redAccent,
                              width: 1,
                              style: BorderStyle.solid)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                height: 50,
                width: widthDevice/1.5,
                child: Container(
                  padding: EdgeInsets.only(top: 1,right: 1,left: 1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Color.fromRGBO(30, 41, 53, 1)
                  ),
                  child: TextFormField(
                    validator: (value){
                      if (passwordController.text.toString().length>=8){
                        return "Password length should be >= 8";
                      }
                      else if (!RegExp(r'[A-Z]+').hasMatch(value.toString())){
                        return "Please Enter at least an UPPERCASE alphabet[A-Z]";
                      }
                      else if (!RegExp(r'[0-9]+').hasMatch(value.toString())){
                        return "Please Enter at least a digit";
                      }
                      else if (!RegExp(r'[!@#$%^&*{}?":><.,-+=_[]]+').hasMatch(value.toString())){
                        return "Please Enter at least a character ";
                      }

                    },
                    obscureText: true,
                    controller: passwordController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye,size: 20,color: Colors.grey,)),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.password,size: 20,color: Colors.grey,),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                              style: BorderStyle.solid)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 1,
                              style: BorderStyle.solid)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.redAccent,
                              width: 1,
                              style: BorderStyle.solid)),
                    ),
                  ),
                ),
              ),

            ],
          )),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(onPressed: (){
                formKey.currentState!.validate();
              },
                padding: EdgeInsets.zero,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3,horizontal: 1),
                  height: 30,
                  width: widthDevice/6.5,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Login",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                ),),
              SizedBox(width: widthDevice/10,),
              MaterialButton(onPressed: (){
                formKey.currentState!.validate();
              },
                padding: EdgeInsets.zero,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3,horizontal: 1),
                  height: 30,
                  width: widthDevice/6.5,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Register",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                ),)
            ],
          ),
        ],
      ),
    );
  }
}
