import 'package:flutter/material.dart';
import 'package:my_noty/model/note.dart';



class ReadNote extends StatelessWidget {
  Note note;
  ReadNote(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          onPressed: (){
         Navigator.of(context).pop();
          },
          icon:const Icon(Icons.arrow_back_ios),),
        centerTitle: true,
        title:const Text('Read Note'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            children: [
              Text(note.title,textAlign: TextAlign.center,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),),
              const  SizedBox(height: 10,),
              Text("${note.date}",textAlign: TextAlign.center,style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
              const  SizedBox(height: 10,),
              Text(note.content,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ) ,
    );
  }
}
