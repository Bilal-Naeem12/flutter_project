class Usermodel {
  String email;
  String password;
  String username;
  String image;
  String id;
  Usermodel(
      {required this.email,
      required this.password,
      required this.username,
      this.image = "",
      this.id = ""});
}
