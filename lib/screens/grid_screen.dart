import 'package:flutter/material.dart';
import 'package:notes_app/screens/create_screen.dart';

import '../model/notes.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key, required this.notes});
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20.0),
      itemBuilder: (context, index) {
        Color itemColor;
        if (notes[index].color == "Red") {
          itemColor = const Color.fromARGB(255, 248, 100, 100);
        } else if (notes[index].color == "Blue") {
          itemColor = const Color.fromARGB(255, 119, 203, 244);
        } else if (notes[index].color == "Yellow") {
          itemColor = const Color.fromARGB(243, 248, 231, 78);
        } else if (notes[index].color == "Green") {
          itemColor = Colors.green[200]!;
        } else {
          itemColor = const Color.fromARGB(240, 255, 255, 255);
        }
        return GridItem(
          note: notes[index],
          itemColor: itemColor,
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: notes.length,
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.note, this.itemColor});

  final Note note;
  final Color? itemColor;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateScreen(
                  note: note,
                )));
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.zero,
      color: itemColor,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
            color: itemColor, border: Border.all(color: Colors.grey[400]!)),
        height: 190,
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 28),
                  ),
                  const Divider(
                    thickness: 2.5,
                  ),
                  Flexible(
                    child: Text(
                      note.desc,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black38),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    "${note.dateTime.day}- ${note.dateTime.month} - ${note.dateTime.year}")
              ],
            )
          ],
        ),
      ),
    );
  }
}
