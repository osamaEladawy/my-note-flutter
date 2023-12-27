import 'package:flutter/material.dart';
import 'package:my_noty/model/note.dart';
import 'package:my_noty/routes/widegets/custom_mybutton.dart';
import 'package:my_noty/routes/widegets/customtextfield.dart';

import '../model/constans.dart';
import '../model/db_helper.dart';

class UpdateNote extends StatefulWidget {
late Note note;
UpdateNote(this.note, {super.key});

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  TextEditingController toTitle = TextEditingController();
  TextEditingController toContent =TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();


  late String title, content;
  bool isValid = false;

  late DbHelper helper;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    toTitle.text = widget.note.title;
    toContent.text=widget.note.content;
  }

  @override
  void dispose() {
    super.dispose();
    toTitle.dispose();
    toContent.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyle.mainColor,
          leading:IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon:const Icon(Icons.arrow_back_ios),),
        title: const Text('Update Note'),
      ),
      body:Form(
        key: formState,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:[
              const SizedBox(height: 10),
              CustomTextFormField(
                controller:toTitle,
               valid: isValid,
                hintText:  widget.note.title,
                labelText: 'Title',
                onChanged: (value) {
                  setState(() {
                    if(value.isNotEmpty){
                      title=value;
                    }
                  });
                },
              ),
              Text("${widget.note.date}",style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              const SizedBox(height: 10),
              Expanded(
                child: CustomTextFormField(
                  maxLines:null,
                  controller: toContent,
                  valid: isValid,
                  hintText: widget.note.content,
                  labelText: 'Content',
                  onChanged: (value){
                    setState(() {
                      if(value.isNotEmpty){
                        content=value;
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              CustomMyButton(
                text:'Save',
              onPressed: (){
                if(formState.currentState!.validate()){
                  isValid = true;
                  var upgrade = Note({
                    'id':widget.note.id,
                    "title":toTitle.text,
                    'content':toContent.text,
                    'date':widget.note.date
                  });
                  helper.updateNotes(upgrade);
                  Navigator.of(context).pop();
                }else{
                  isValid = false;
                  print("not valid");
                }
              },),
            ]
          ),
        ),
      )
    );
  }
}
