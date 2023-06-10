import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/Firebase_helper.dart';
import 'data_controller.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  Map data = Get.arguments;
  AddScreenController  getx = Get.put(AddScreenController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(data['check'] == 0)
    {
      getx.txtTime = TextEditingController(text: "${data['time']}",);
      getx.txtDate = TextEditingController(text: "${data['date']}");
      getx.txtNotes = TextEditingController(text: "${data['notes']}");
      getx.txtProrority = TextEditingController(text: "${data['priority']}");
      getx.txtTitle = TextEditingController(text: "${data['title']}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Add Data"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: getx.txtTitle,
                  decoration: InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                    ),
                  ),
                ),
                 SizedBox(height: 2,),
                TextField(
                  controller: getx.txtDate,
                  decoration: InputDecoration(
                      hintText: "Date",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      )
                  ),
                ),
                SizedBox(height: 2,),
                TextField(
                  controller: getx.txtTime,
                  decoration: InputDecoration(
                      hintText: "Time",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      )
                  ),
                ),
                // SizedBox(height: 2.h,),
                TextField(
                  controller: getx.txtProrority,
                  decoration: InputDecoration(
                      hintText: "Proirity",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      )
                  ),
                ),
                 SizedBox(height: 2,),
                TextField(
                  controller: getx.txtNotes,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "Note",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      )
                  ),
                ),

                SizedBox(height: 2,),
                data['check']==1?ElevatedButton(onPressed: () {
                  if(getx.txtTime.text != null && getx.txtProrority.text != null &&getx.txtNotes.text != null &&getx.txtTitle.text != null && getx.txtDate.text != null )
                  {
                    FireBaseHelper.fireBaseHelper.addData(date: getx.txtDate.text,title: getx.txtTitle.text,notes: getx.txtNotes.text,priority: getx.txtProrority.text,time: getx.txtTime.text);
                    Get.toNamed("/data");
                  }
                  else
                  {
                    Get.snackbar("update", "Enter Required Data");
                  }
                }, child: Text("Enter Data"),):ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed:
                        () {
                  FireBaseHelper.fireBaseHelper.updateData(key: data['id'],date: getx.txtDate.text,title: getx.txtTitle.text,priority: getx.txtProrority.text,time: getx.txtTime.text,notes: getx.txtNotes.text);
                   Get.back();
                }, child: Text("Update Data")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
