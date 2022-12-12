part of 'note.dart';

class CheckItem extends Equatable {
  const CheckItem(this.text, this.checked);

  static CheckItem get empty => const CheckItem('', false);

  final String text;
  final bool checked;

  @override
  List<Object?> get props => [text, checked];

  CheckItem copyWith({String? text, bool? checked}) {
    return CheckItem(
      text ?? this.text,
      checked ?? this.checked,
    );
  }
}
