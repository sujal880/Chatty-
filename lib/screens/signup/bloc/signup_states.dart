class SignUpStates {
  final String email;
  final String password;
  final String confirmpassword;

  SignUpStates(
      { this.email="",
       this.confirmpassword="",
       this.password=""});

  SignUpStates copyWith(
      {String? email, String? password, String? confirmpassword}) {
    return SignUpStates(
        email: email ?? this.email,
        confirmpassword: confirmpassword ?? this.confirmpassword,
        password: password ?? this.password);
  }
}
