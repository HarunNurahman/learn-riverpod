class TodoModel {
  final String? id;
  final String? text;
  final String? desc;

  TodoModel({
    this.id,
    this.text,
    this.desc,
  });

  TodoModel copyWith({
    String? id,
    String? text,
    String? desc,
  }) {
    return TodoModel(
      id: id ?? this.id,
      text: text ?? this.text,
      desc: desc ?? this.desc,
    );
  }
}
