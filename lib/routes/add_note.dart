import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_noty/model/db_helper.dart';
import 'package:my_noty/model/note.dart';
import 'package:my_noty/routes/widegets/custom_mybutton.dart';
import 'package:my_noty/routes/widegets/customtextfield.dart';

import '../model/constans.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late DbHelper helper;
  late String title, content;
  int color = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isValid = false;

  //late Image image;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Add Note'),
      ),
      body: Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                valid: isValid,
                hintText: "Enter your title Note",
                labelText: 'Title',
                onChanged: (newValue) {
                  setState(() {
                    title = newValue;
                  });
                },
              ),
              Text(
                date,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: CustomTextFormField(
                  valid: isValid,
                  maxLines: null,
                  hintText: "Enter your content Note",
                  labelText: 'Content',
                  onChanged: (newValue) {
                    setState(() {
                      content = newValue;
                    });
                  },
                ),
              ),
              CustomMyButton(
                text: "Save",
                onPressed: () async {
                  if (formState.currentState!.validate()) {
                    isValid = true;
                    Note note = Note({
                      "title": title,
                      "content": content,
                      "date": date,
                    });
                    int id = await helper.createNote(note);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('notes $id is saves now',style: TextStyle(
                        color: AppStyle.mainColor
                      ),),
                      backgroundColor:Colors.white,
                    ));
                  } else {
                    isValid = false;
                    print("not valid message");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
