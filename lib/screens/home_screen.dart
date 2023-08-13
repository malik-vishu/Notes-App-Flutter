import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/model/db.dart';
import 'package:notes_app/screens/create_screen.dart';
import 'package:notes_app/screens/empty_screen.dart';
import 'package:notes_app/screens/grid_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateScreen()));
        },
        backgroundColor: Colors.green[300],
        splashColor: Colors.green[100],
        tooltip: "Create Note",
        child: const Icon(CupertinoIcons.add),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.green[50]),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: ["Notes".text.headline4(context).black.make()],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  Expanded(
                    child: StreamBuilder(
                        stream: LocalDBService().listenAllNotes(),
                        builder: (context, snapshot) => (snapshot.data == null)
                            ? const EmptyScreen()
                            : GridScreen(notes: snapshot.data!)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
