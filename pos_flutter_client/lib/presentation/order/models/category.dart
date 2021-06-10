class Category {
  final String name;
  final String color;
  final int id;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Category({
    required this.name,
    required this.color,
    required this.id,
  });

  Category copyWith({
    String? name,
    String? color,
    int? id,
  }) {
    if ((name == null || identical(name, this.name)) &&
        (color == null || identical(color, this.color)) &&
        (id == null || identical(id, this.id))) {
      return this;
    }

    return new Category(
      name: name ?? this.name,
      color: color ?? this.color,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'Category{name: $name, color: $color, id: $id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          color == other.color &&
          id == other.id);

  @override
  int get hashCode => name.hashCode ^ color.hashCode ^ id.hashCode;

//</editor-fold>

}
