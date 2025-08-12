import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/note_list_screen.dart';
import 'providers/note_provider.dart';

void main() {
  runApp(const NoteTakerApp());
}

class NoteTakerApp extends StatelessWidget {
  const NoteTakerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteProvider(),
      child: MaterialApp(
        title: 'Note Taker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NoteListScreen(),
      ),
    );
  }
}
