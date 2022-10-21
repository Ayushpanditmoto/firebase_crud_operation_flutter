// ignore_for_file: file_names

import 'package:firebase_crud_operation/editNote.dart';
import 'package:firebase_crud_operation/provider/DataBaseServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build");
    final notes = Provider.of<FireBaseService>(context, listen: false);
    return StreamBuilder(
        stream: notes.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index]['topic']),
                      subtitle: Text(snapshot.data!.docs[index]['note']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditNote(
                                    topic: snapshot.data!.docs[index]['topic'],
                                    note: snapshot.data!.docs[index]['note'],
                                    id: snapshot.data!.docs[index].id,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              notes.deleteNote(snapshot.data!.docs[index].id);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
