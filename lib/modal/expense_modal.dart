class Contact {
  int? id;
  String name;
  String phoneNumber;
  String email;
  String category;
  bool isFavorite;

  Contact({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.category,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'category': category,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      category: map['category'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}