import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_noty/model/db_helper.dart';
import 'package:my_noty/model/note.dart';
import 'package:my_noty/routes/add_note.dart';
import 'package:my_noty/routes/read_note.dart';
import 'package:my_noty/routes/update_note.dart';

import '../model/constans.dart';
import '../my _card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DbHelper helper;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.mainColor,
        appBar: AppBar(
          title: const Text(
            "My Notes",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppStyle.mainColor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const AddNote()));
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
            )
          ],
        ),
        body: WillPopScope(
          onWillPop: () {
            showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: const Text(
                        "Haye!",
                        textAlign: TextAlign.center,
                      ),
                      content: const Text(
                        "Are you sure you want to exit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).maybePop();
                                },
                                child: const Text("No")),
                            ElevatedButton(
                                onPressed: () {
                                  exit(0);
                                },
                                child: const Text("Yes")),
                          ],
                        ),
                      ],
                    ));
            return Future.value(false);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Your recent Notes",
                    style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: helper.selectAllNotes(),
                      builder: (context, snapShot) {
                        if (snapShot.hasError) {
                          throw Exception('sorry not data here');
                        } else if (snapShot.hasData) {
                          var notes = snapShot.data;
                          var note =
                          notes!.map((e) => Note.fromMap(e)).toList();
                          return GridView.count(
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            children: [
                              // noteCard(context, notes)
                              ...note.map((e) => noteCard(context, e)).toList(),
                            ],
                          );
                        } else if (!snapShot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  Widget noteCard(BuildContext context, Note note) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ReadNote(note),
        ));
      },
      child: Card(
        color: AppStyle.cardsColor[note.id!],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                        note.title,
                        style: AppStyle.mainTitle,
                      )),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        helper.deleteNotes(note.id!);
                      });

                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                        "${note.date}",
                        style: AppStyle.dataTile,
                      )),
                  Builder(
                    builder: (BuildContext context) => IconButton(
                      onPressed: () async {
                        var result =
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateNote(note),
                        ));
                        setState(() {
                          result;
                        });
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Expanded(
                child: Text(note.content,
                    style: AppStyle.mainContent, overflow: TextOverflow.ellipsis,),
              ),
            ],
          ),
        ),
      ),
    );
  }






}

