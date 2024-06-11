import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  //const NoteDetail({super.key});
  String appBarTitle;
  NoteDetail(this.appBarTitle, {super.key});

  @override
  State<NoteDetail> createState() => NoteDetailState(appBarTitle);
}

class NoteDetailState extends State<NoteDetail> {
  static final _priorities = ['High', 'Low'];

  String appBarTitle;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteDetailState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleLarge;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            moveToLastScreen();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            //First Element
            ListTile(
              title: DropdownButton(
                items: _priorities.map((dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                style: textStyle,
                value: 'Low',
                onChanged: (valueSelectedByUser) {
                  setState(() {
                    debugPrint('User Selected $valueSelectedByUser');
                  });
                },
              ),
            ),

            //Second Element
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in the Title Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),

            //Third Element
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in the Description Text Field');
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),

            // Fourth Element
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      debugPrint('Save button clicked');
                    },
                    child: const Text(
                      'Save',
                      textScaleFactor: 1.5,
                    ),
                  )),
                  Expanded(
                      child: ElevatedButton(
                    //style: ,
                    onPressed: () {
                      debugPrint('Delete button clicked');
                    },
                    child: const Text(
                      'Delete',
                      //style: TextStyle(color: Colors.deepPurple),
                      textScaleFactor: 1.5,
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
