import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../utils/Firebase_helper.dart';
import '../utils/notification_helper.dart';
import 'data_model.dart';

class DataSee extends StatefulWidget {
  const DataSee({Key? key}) : super(key: key);

  @override
  State<DataSee> createState() => _DataSeeState();
}

class _DataSeeState extends State<DataSee> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Data"),
          actions: [
            IconButton(
                onPressed: () async {
                  await NotificationHelper.Helper.showSimpleNotification();
                },
                icon: Icon(Icons.notifications)),
          ],
        ),
        body: StreamBuilder(
          stream: FireBaseHelper.fireBaseHelper.readData(),
          builder: (context, snapshot) {
            print("====================");
            print(snapshot.hasData);
            if(snapshot.hasError)
            {
              return Text("Error:-${snapshot.error}");
            }
            else  if(snapshot.hasData)
            {
              List<DataSeeModal> listData = [];
              QuerySnapshot? snapData = snapshot.data;
              for(var x in snapData!.docs)
              {
                Map? data = x.data() as Map;

                String? title = data['title'];
                String? notes = data['notes'];
                String? priority = data['priority'];
                String? time = data['time'];
                String? date = data['date'];print("-================  $title");
                DataSeeModal t1 = DataSeeModal(time: time,priority: priority,title: title,date: date,noter: notes,id: x.id);
                listData.add(t1);
              }

              return ListView.builder(itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    Map args = {
                      "check":0,
                      "title":'${listData[index].title}',
                      "id":'${listData[index].id}',
                      "date":'${listData[index].date}',
                      "time":'${listData[index].time}',
                      "priority":'${listData[index].priority}',
                      "notes":'${listData[index].noter}',
                    };
                    Get.toNamed('/add',arguments: args);
                  },
                  child: Container(
                    margin: EdgeInsets.all(1),
                    padding: EdgeInsets.all(2),
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(1),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          child: Text("${listData[index].title} (${listData[index].priority})    "),
                        ),
                      ],
                    ),
                  ),
                );
              },itemCount: listData.length,);
            }
            return Center(child: CircularProgressIndicator(),);
          },),
      ),
    );
  }
}
