part of 'note.dart';

class NoteColor extends Equatable {
  const NoteColor(this.name, this.value);

  final String name;
  final int value;

  @override
  List<Object?> get props => [name, value];

  static NoteColor parse(String source) => colors.singleWhere(
        (color) => color.name == source,
        orElse: () => throw Exception('Unable to parse color $source'),
      );

  static NoteColor? parseNullable(String? source) =>
      source != null ? parse(source) : null;

  @override
  String toString() => name;

  static final colors = [
    NoteColor('pink', Colors.pink.value),
    NoteColor('purple', Colors.purple.value),
    NoteColor('deepPurple', Colors.deepPurple.value),
    NoteColor('indigo', Colors.indigo.value),
    NoteColor('blue', Colors.blue.value),
    NoteColor('lightBlue', Colors.lightBlue.value),
    NoteColor('cyan', Colors.cyan.value),
    NoteColor('teal', Colors.teal.value),
    NoteColor('green', Colors.green.value),
    NoteColor('lightGreen', Colors.lightGreen.value),
    NoteColor('lime', Colors.lime.value),
    NoteColor('yellow', Colors.yellow.value),
    NoteColor('amber', Colors.amber.value),
    NoteColor('orange', Colors.orange.value),
    NoteColor('deepOrange', Colors.deepOrange.value),
    NoteColor('blueGrey', Colors.blueGrey.value),
  ];
}
