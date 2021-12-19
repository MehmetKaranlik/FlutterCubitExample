import 'package:cubit_example/common/test_view/viewmodel/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> validationKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        emailController: emailController,
        passwordController: passwordController,
        validationKey: validationKey,
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return _buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold _buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
      appBar: AppBar(title: const Text("LoginView")),
      body: Form(
        key: validationKey,
        autovalidateMode: _buildAutoValidate(state),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextFormFieldEmail(),
            const SizedBox(
              height: 20,
            ),
            _buildTextFormFieldPassword(),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () => context.read<LoginCubit>().postUserModel(),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  AutovalidateMode _buildAutoValidate(LoginState state) {
    return state is LoginValidateState
          ? (state.isValidate ? AutovalidateMode.always : AutovalidateMode.disabled)
          : AutovalidateMode.disabled;
  }

  TextFormField _buildTextFormFieldPassword() {
    return TextFormField(
      controller: passwordController,
      validator: (value) => (value ?? "").length > 6 ? null : "6'dan küçük",
      decoration: _buildTFFDecoration().copyWith(label: const Text("Password")),
    );
  }

  TextFormField _buildTextFormFieldEmail() {
    return TextFormField(
      controller: emailController,
      validator: (value) => (value ?? "").length > 6 ? null : "6'dan küçük",
      decoration: _buildTFFDecoration(),
    );
  }

  InputDecoration _buildTFFDecoration() {
    return const InputDecoration(border: OutlineInputBorder(), label: Text("E-mail"));
  }
}
