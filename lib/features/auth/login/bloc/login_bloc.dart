import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../core/services/firebase_services/firebase_authentication.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginInitial()) {

    on<OnLogin>((event, emit) async {

      emit(LoginLoading());

      try {

        final credential = await FirebaseAuthentication().loginUser(
          event.email,
          event.password,
        );

        if (credential.user != null) {
          emit(LoginSuccess());
        }

      } on FirebaseAuthException catch (e) {

        emit(LoginError(e.message ?? "Login Failed"));

      } catch (e) {

        emit(LoginError(e.toString()));

      }

    });

  }

}