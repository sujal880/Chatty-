import 'package:chatty/screens/login/bloc/login_events.dart';
import 'package:chatty/screens/login/bloc/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvents,LoginState>{
  LoginBloc():super(LoginState()){
    on<EmailEvents>(_emailEvents);
    on<PasswordEvents>(_passwordEvents);
  }
  _emailEvents(EmailEvents emailEvents,Emitter<LoginState> emit){
    emit(state.copyWith(email: emailEvents.email));
  }

  _passwordEvents(PasswordEvents passwordEvents,Emitter<LoginState>emit){
    emit(state.copyWith(password: passwordEvents.password));
  }
}