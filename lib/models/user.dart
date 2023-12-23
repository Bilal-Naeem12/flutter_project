class Usermodel {
  final String email;
  final String password;
  String username;
  final String image;

  Usermodel(
      {required this.email,
      required this.password,
      required this.username,
      this.image = ""});
}
