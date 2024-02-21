class User {
  final int id;
  final String id_type;
  final String identification;
  final String firstName;
  final String lastName;
  final String email;
  final int role_id;
  final String username;
  final String password;

  User({
    required this.id,
    required this.id_type,
    required this.identification,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role_id,
    required this.username,
    required this.password,
  });

  
  factory User.fromJson(Map<String, dynamic>? json) {
    print("from Json");
    print(json);
    return User(
      id: json?['id'],
      id_type: json?['id_type'],
      identification: json?['identification'],
      firstName: json?['firstName'],
      lastName: json?['lastName'],
      email: json?['email'],
      role_id: json?['role_id']['id'],
      username: json?['username'],
      password: json?['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_type': id_type,
      'identification': identification,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role_id': role_id,
      'username': username,
      'password': password,
    };
  }

  factory User.fromJson2(Map<String, dynamic>? json) {
    print("from Json");
    print(json);
    return User(
        id: json?['id'],
        id_type: json?['id_type'],
        identification: json?['identification'],
        firstName: json?['firstName'],
        lastName: json?['lastName'],
        email: json?['email'],
        role_id: json?['id'],
        username: json?['username'],
        password: json?['password']);
  }
}

class UserRole {
  final int id;
  final String roleName;
  final String roleDescription;

  UserRole({
    required this.id,
    required this.roleName,
    required this.roleDescription,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      id: json['id'],
      roleName: json['role_name'],
      roleDescription: json['role_description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_name': roleName,
      'role_description': roleDescription,
    };
  }
}
