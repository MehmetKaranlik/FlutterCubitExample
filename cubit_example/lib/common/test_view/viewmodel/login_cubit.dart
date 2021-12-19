import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> validationKey;
  

  bool isLoginFailed = false;

  LoginCubit({
    required this.validationKey,
    required this.emailController,
    required this.passwordController,
  }) : super(LoginInitial());
  void postUserModel () {
    if (validationKey.currentState?.validate() ?? false) {

    }else {
      isLoginFailed = true;
      emit(LoginValidateState(isLoginFailed));
    }
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}


class LoginValidateState extends LoginState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}
