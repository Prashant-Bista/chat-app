import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

import 'package:chat_app/services/media_services.dart';
import 'package:chat_app/services/database_service.dart';
import 'package:chat_app/services/cloud_storage_service.dart';

import 'package:chat_app/widgets/custom_form_field.dart';
import 'package:chat_app/widgets/rounded_button.dart';

import 'package:chat_app/providers/authentication_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late String _email;
  late String _password;
  late String _name;

  PlatformFile? _profileImage;
  late AuthenticationProvider  _authProv;
  CloudStorageService _cloudStorageService = CloudStorageService();
  DatabaseService _dbService = DatabaseService();
  GlobalKey<FormState> _registerFormKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _deviceWidth= MediaQuery.of(context).size.width;
    _deviceHeight= MediaQuery.of(context).size.height;
    _authProv = Provider.of<AuthenticationProvider>(context);
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: Form(
        key: _registerFormKey,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "Register an Account",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                    _profileImageField(),
                SizedBox(height: 20,),
                SizedBox(
                  width: _deviceWidth*0.8,
                  child: CustomFormField(
                    onSaved: (value) {
                      _password = value;
                    },
                    regEx: r'.{1,}',
                    hintText: 'Name',
                    obscureText: false,
                  ),
                ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: _deviceWidth*0.8,
                      child: CustomFormField(
                        onSaved: (value) {
                          _email = value;
                        },
                        regEx: r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        hintText: 'Email',
                        obscureText: false,
                      ),
                    ),
                SizedBox(height: 20,),
                SizedBox(
                  width: _deviceWidth*0.8,
                  child: CustomFormField(
                    onSaved: (value) {
                      _password = value;
                    },
                    regEx: r'.{8,}',
                    hintText: 'Password',
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 20,),
                RoundedButton(name: "Register", height: _deviceWidth*0.06, width: _deviceWidth*0.25, onpressed: () async{
                 if(_registerFormKey.currentState!.validate() && _profileImage!=null){
                   _registerFormKey.currentState!.save();
                   print("email:${_email}\npassword:${_password}");
                   String? _uid= await _authProv.signUpWithEmailAndPassword(_email,_password);
                   String? _imageUrl =await _cloudStorageService.saveUserImageToStorage(_uid!, _profileImage!);
                   print(_imageUrl);
                   await _dbService.createUser(_uid, _name, _imageUrl!, _email);
                   _authProv.setUser(_uid);


                 }
                })
              ]),
        ),
      ),
    );
  }
  Widget _profileImageField(){
  return InkWell(
    onTap: (){
        GetIt.instance.get<MediaService>().pickImageFromLibrary().then((_file){
          setState(() {
            _profileImage= _file;
          });

      });
      },
    child: (){
      if (_profileImage!=null){
        if(kIsWeb){
          return CircleAvatar(
            backgroundImage: MemoryImage(_profileImage!.bytes!),
            radius: 75,
          );

        }
        else
          {
            return CircleAvatar(
              backgroundImage: AssetImage(_profileImage!.path!),
              radius: 75,
            );

          }
      }
      else{
        return CircleAvatar(
          backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEUD2dc9rSHjWwKNLNkHQHVRir4vvZdblkSQ&s"),
          radius: 75,
        );
      }
    }(),
  );
  }
}

