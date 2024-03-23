import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:music/data/model/song.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authRepository = AuthRepostory(service: AuthServices());

abstract class IAutRepository {
  Future<AuthResponse> singIn(String email, String password);
  Future<AuthResponse> singUp(String email, String password);
}

class AuthRepostory implements IAutRepository {
  final IAuthServices service;

  AuthRepostory({required this.service});
  @override
  Future<AuthResponse> singIn(String email, String password) {
    return service.singIn(email, password);
  }

  @override
  Future<AuthResponse> singUp(String email, String password) {
    return service.singUp(email, password);
  }
}

abstract class IAuthServices {
  Future<AuthResponse> singIn(String email, String password);
  Future<AuthResponse> singUp(String email, String password);
}

class AuthServices implements IAuthServices {
  final supabase = Supabase.instance.client;

  @override
  Future<AuthResponse> singIn(String email, String password) async {
    final auth = await supabase.auth
        .signInWithPassword(email: email, password: password);
    debugPrint(auth.session!.accessToken);
    return auth;
  }

  @override
  Future<AuthResponse> singUp(String email, String password) async {
    final auth = await supabase.auth.signUp(password: password, email: email);
    return auth;
  }
}
