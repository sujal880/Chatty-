import 'package:chatty/screens/signup/bloc/signup_events.dart';
import 'package:chatty/screens/signup/bloc/signup_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvents,SignUpStates>{
  SignUpBloc():super(SignUpStates()){
    on<EmailEvents>(_emailEvents);
    on<PasswordEvents>(_passwordEvents);
    on<ConfirmPasswordEvents>(_confirmPasswordEvents);
  }

  void _emailEvents(EmailEvents emailEvents,Emitter<SignUpStates>emit){
    emit(state.copyWith(email: emailEvents.email));
  }

  void _passwordEvents(PasswordEvents passwordEvents,Emitter<SignUpStates>emit){
    emit(state.copyWith(password: passwordEvents.password));
  }

  void _confirmPasswordEvents(ConfirmPasswordEvents confirmPasswordEvents,Emitter<SignUpStates>emit){
    emit(state.copyWith(confirmpassword: confirmPasswordEvents.confirmpassword));
  }
}