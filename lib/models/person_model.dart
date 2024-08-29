class PersonModel {
  final String? name;
  final int? age;

  PersonModel(this.name, this.age);

  PersonModel copyWith({
    String? name,
    int? age,
  }) =>
      PersonModel(
        name ?? this.name,
        age ?? this.age,
      );
}
