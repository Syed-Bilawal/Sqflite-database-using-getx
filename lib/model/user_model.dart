class UserModel {
  int? id;
  String name;
  int age;

  UserModel({
    this.id,
    required this.name,
    required this.age,
  });

  // Factory constructor for creating a new User instance from a map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
    );
  }

  // Method for converting a User instance into a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Method for creating a copy of the User instance with modified attributes
  UserModel copyWith({
    int? id,
    String? name,
    int? age,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}
