import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddScreenController extends GetxController
{
  TextEditingController txtNotes = TextEditingController();
  TextEditingController txtDate = TextEditingController(text: "${DateTime.now()}");
  TextEditingController txtTime = TextEditingController(text: "${TimeOfDay.now()}");
  TextEditingController txtProrority = TextEditingController();
  TextEditingController txtTitle = TextEditingController();
}
