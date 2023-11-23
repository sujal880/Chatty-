abstract class SignUpEvents{
  const SignUpEvents();
}

class EmailEvents extends SignUpEvents{
  final String email;
  EmailEvents({required this.email});
}

class PasswordEvents extends SignUpEvents{
  final String password;
  PasswordEvents({required this.password});
}

class ConfirmPasswordEvents extends SignUpEvents{
  final String confirmpassword;
  ConfirmPasswordEvents({required this.confirmpassword});
}