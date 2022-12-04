class LoginRequest {
  String username;
  String password;

  LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, String> toJson() => {
        "username": username,
        "password": password,
      };
}
