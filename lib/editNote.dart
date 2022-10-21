// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/DataBaseServices.dart';

class EditNote extends StatelessWidget {
  String id;
  String topic;
  String note;
  EditNote(
      {super.key, required this.id, required this.topic, required this.note});
  TextEditingController topicController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<FireBaseService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: topicController..text = topic,
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
                controller: noteController..text = note,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    database.updateNote(
                        id, topicController.text, noteController.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
