class Category {
  final String name;

  Category({required this.name});

  @override
  bool operator ==(dynamic other) =>
      other != null && other is Category && this.name == other.name;

  @override
  int get hashCode => super.hashCode;
}
