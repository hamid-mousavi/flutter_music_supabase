import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/Screens/Auth/bloc/auth_bloc.dart';
import 'package:music/Screens/Home/home_page.dart';
import 'package:music/data/Services/Auth/AuthService.dart';
import 'package:music/theme/AppTheme.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return BlocProvider<AuthBloc>(
      create: (context) {
        final bloc = AuthBloc(authRepository);
        bloc.stream.forEach((state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pop();
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error.toString())));
          }
        });
        bloc.add(AuthStarted());
        return bloc;
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Wellcome',
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: AppTheme.fontCaptionColor),
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : 'enter a valid email',
                      decoration: const InputDecoration(hintText: 'Email'),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(color: AppTheme.fontCaptionColor),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'password',
                      ),
                    ),
                    const SizedBox(height: 30),
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (previous, current) {
                        return current is AuthError ||
                            current is AuthInitial ||
                            current is AuthLoading;
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: 500,
                          height: 40,
                          child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppTheme.primaryColor)),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                    LoginBtnClick(
                                        email: _emailController.text,
                                        password: _passwordController.text));
                              },
                              child: (state is AuthLoading)
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'Login',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    )),
                        );
                      },
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
