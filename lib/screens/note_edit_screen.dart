import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';

class NoteEditScreen extends StatefulWidget {
  final Note? note;
  const NoteEditScreen({Key? key, this.note}) : super(key: key);

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;

  @override
  void initState() {
    super.initState();
    _title = widget.note?.title ?? '';
    _content = widget.note?.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a title' : null,
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _content,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 5,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter content' : null,
                onSaved: (value) => _content = value!,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                child: Text(widget.note == null ? 'Add' : 'Update'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final provider =
                        Provider.of<NoteProvider>(context, listen: false);
                    if (widget.note == null) {
                      await provider.addNote(
                        Note(
                            title: _title,
                            content: _content,
                            createdAt: DateTime.now()),
                      );
                    } else {
                      await provider.updateNote(
                        Note(
                          id: widget.note!.id,
                          title: _title,
                          content: _content,
                          createdAt: widget.note!.createdAt,
                        ),
                      );
                    }
                    Navigator.pop(context);
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
