import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:io';
const String USER_COLLECTION= "users";

class CloudStorageService{
  final FirebaseStorage _stoage = FirebaseStorage.instance;
  CloudStorageService(){}
}