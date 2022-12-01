part of 'note.dart';

class CheckItem extends Equatable {
  const CheckItem(this.text, this.checked);

  final String text;
  final bool checked;

  @override
  List<Object?> get props => [text, checked];
}
