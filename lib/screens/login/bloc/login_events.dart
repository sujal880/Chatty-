abstract class LoginEvents{
  const LoginEvents();
}

class EmailEvents extends LoginEvents{
  String email;
  EmailEvents({required this.email});
}

class PasswordEvents extends LoginEvents{
  String password;
  PasswordEvents({required this.password});
}