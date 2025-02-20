import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:io';

import 'package:flutter/foundation.dart';
const String USER_COLLECTION= "users";

class CloudStorageService{
  final FirebaseStorage _stoage = FirebaseStorage.instance;
  CloudStorageService(){}
  Future<String?> saveUserImageToStorage(String _uid,PlatformFile _image) async{
    UploadTask _task;
    try{
      Reference _ref = _stoage.ref().child("images/users/$_uid/profile.${_image.extension}");
      if(kIsWeb){
         _task =  _ref.putData(Uint8List.fromList(_image.bytes!));
      }
      else{
        _task =  _ref.putFile(File(_image.path!));
      }

      print("image saving started");
      TaskSnapshot snapshot = await _task;
      print("image saving happened");
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print(downloadUrl);
      return downloadUrl;
    }catch(e){
      print(e);
    }
    return null;
    
  }
  Future<String?> saveChatImageToStorage(String _chatID, String _userId, PlatformFile _file) async{
    UploadTask _task;

    try{
    Reference _ref = _stoage.ref().child("images/chats/$_chatID/${_userId}_${Timestamp.now().microsecondsSinceEpoch}.${_file.extension}");
    UploadTask _task;
    if(kIsWeb){
      _task =  _ref.putData(Uint8List.fromList(_file.bytes!));
    }
    else{
      _task =  _ref.putFile(File(_file.path!));
    }
    return await _task.then((_result)=>_result.ref.getDownloadURL());
  }
  catch(e){
  }
  }
}