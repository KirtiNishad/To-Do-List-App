import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:to_do_list_app/core/services/firebase_services/firebase_authentication.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {

  SignUpBloc() : super(SignUpInitial()) {
    on<OnSignUp>((event, emit) async {
      emit(SignUpLoading());

      try {
        final credential = await FirebaseAuthentication().registerUser(
          event.email,
          event.password
        );

        if (credential.user != null) {
          emit(SignUpSuccess());
        }
      } on FirebaseAuthException catch (e) {
        emit(SignUpError(e.message.toString()));
      } catch (e) {
        emit(SignUpError(e.toString()));
      }
    });
  }
}
