class UserModel{
  final String name;
  final String email;
  final String id;
  final String uid;

  UserModel({required this.name, required this.email, required this.id, required this.uid});

  UserModel.fromJson(Map<String, dynamic>? json)
  :name = json!["name"],
  email = json["email"],
  id = json["id"],
  uid = json["uid"];
}