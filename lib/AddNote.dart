// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/DataBaseServices.dart';

class AddNote extends StatelessWidget {
  AddNote({Key? key}) : super(key: key);
  TextEditingController topic = TextEditingController();
  TextEditingController note = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<FireBaseService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: topic,
                validator: (value) =>
                    value!.isEmpty ? 'Topic is required' : null,
                decoration: const InputDecoration(
                  labelText: 'Topic',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  hintText: 'Topic',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: note,
                maxLines: 7,
                minLines: 1,
                validator: (value) => value!.isEmpty ? 'Enter Note' : null,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  hintText: 'Note',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 6, 69, 164),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    minimumSize: const Size(double.infinity, 50)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    database.addNote(topic.text, note.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
