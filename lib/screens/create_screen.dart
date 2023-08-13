import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/model/notes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../model/db.dart';

enum ColorOptions { red, green, blue, yellow, white }

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key, this.note});
  final Note? note;
  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _tController = TextEditingController();
  final TextEditingController _dController = TextEditingController();

  final localDb = LocalDBService();
  ColorOptions? selectedOption;
  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _tController.text = widget.note!.title;
      _dController.text = widget.note!.desc;
    }
  }

  @override
  void dispose() {
    super.dispose();

    log(_tController.text);
    log(_dController.text);
    log(selectedOption.toString());

    final title = _tController.text;
    final desc = _dController.text;
    String selectedColor;

    if (selectedOption == ColorOptions.red) {
      selectedColor = "Red";
    } else if (selectedOption == ColorOptions.blue) {
      selectedColor = "Blue";
    } else if (selectedOption == ColorOptions.green) {
      selectedColor = "Green";
    } else if (selectedOption == ColorOptions.yellow) {
      selectedColor = "Yellow";
    } else if (selectedOption == ColorOptions.white) {
      selectedColor = "White";
    } else {
      selectedColor = "White";
    }

    if (widget.note != null) {
      if (title.isEmptyOrNull && desc.isEmptyOrNull) {
        localDb.deleteNote(id: widget.note!.id);
      } else if (widget.note!.title != title ||
          widget.note!.desc != desc ||
          (widget.note!.color != selectedColor && selectedOption != null)) {
        final newNote = widget.note!
            .copyWith(title: title, desc: desc, color: selectedColor);
        localDb.saveNote(note: newNote);
      }
    } else {
      if (!title.isEmptyOrNull || !desc.isEmptyOrNull) {
        final newNote = Note(
            id: Isar.autoIncrement,
            title: title,
            desc: desc,
            dateTime: DateTime.now(),
            color: selectedColor);
        localDb.saveNote(note: newNote);
      }
    }

    _tController.dispose();
    _dController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.grey[800],
                      ),
                    ),
                    const Spacer(),
                    widget.note != null
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                            child: IconButton(
                              icon: const Icon(Icons.delete_outline_rounded),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        icon: const Icon(
                                          Icons.delete_outline_rounded,
                                          color: Colors.red,
                                        ),
                                        iconPadding: const EdgeInsets.all(8),
                                        title: const Text(
                                          "Confirm",
                                          style: TextStyle(fontSize: 26),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                localDb.deleteNote(
                                                    id: widget.note!.id);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel")),
                                        ],
                                      );
                                    });
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                    PopupMenuButton(
                        icon: const Icon(
                          CupertinoIcons.paintbrush,
                          color: Colors.black,
                        ),
                        color: const Color.fromARGB(255, 56, 57, 59),
                        initialValue: selectedOption,
                        // Callback that sets the selected popup menu item.
                        onSelected: (ColorOptions item) {
                          setState(() {
                            selectedOption = item;
                          });
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<ColorOptions>>[
                              const PopupMenuItem<ColorOptions>(
                                value: ColorOptions.red,
                                child: Text(
                                  'Red',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 248, 100, 100)),
                                ),
                              ),
                              PopupMenuItem<ColorOptions>(
                                value: ColorOptions.green,
                                child: Text(
                                  'Green',
                                  style: TextStyle(color: Colors.green[200]),
                                ),
                              ),
                              const PopupMenuItem<ColorOptions>(
                                value: ColorOptions.blue,
                                child: Text('Blue',
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 119, 203, 244))),
                              ),
                              const PopupMenuItem<ColorOptions>(
                                value: ColorOptions.yellow,
                                child: Text('Yellow',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(243, 248, 231, 78))),
                              ),
                              const PopupMenuItem<ColorOptions>(
                                value: ColorOptions.white,
                                child: Text('White',
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            240, 255, 255, 255))),
                              ),
                            ])
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _tController,
                    style: const TextStyle(fontSize: 35),
                    decoration: const InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(fontSize: 35),
                        hintMaxLines: 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _dController,
                    scrollPhysics: const BouncingScrollPhysics(),
                    scrollPadding: EdgeInsets.zero,
                    maxLines: 10,
                    style: const TextStyle(fontSize: 30),
                    decoration: const InputDecoration(
                      hintText: "Description",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 30),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
