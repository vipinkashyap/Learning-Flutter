import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';

class NotesGrid extends StatelessWidget {
  final List<Note> notes;
  final void Function(Note) onTap;
  const NotesGrid({Key? key, required this.notes, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.8),
        delegate: SliverChildBuilderDelegate((context, index) {
          final Note note = notes[index];
          return _buildNote(note);
        }, childCount: notes.length),
      ),
    );
  }

  GestureDetector _buildNote(Note note) {
    return GestureDetector(
      onTap: () => onTap(note),
      child: Card(
        color: Colors.orange,
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    note.content,
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                Text(
                  DateFormat.yMd().add_jm().format(note.timestamp),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600),
                )
              ]),
        ),
      ),
    );
  }
}
