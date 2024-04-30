import 'dart:html';

import 'package:articles_app/core/failure/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDB {
  Future<String> SignUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<String> SignInWithEmail({
    required String email,
    required String password,
  });
}

class AuthRemoteDBImpl implements AuthRemoteDB {
  final SupabaseClient supabaseClient;
  AuthRemoteDBImpl(this.supabaseClient);

  @override
  Future<String> SignInWithEmail(
      {required String email, required String password}) {
    // TODO: implement SignInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<String> SignUpWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {"name": name});
      print(response);
      if (response.user == null) {
        throw ServerException(message: "Error Creating user");
      }
      return response.user!.id;
    } catch (e) {
      print(e);
      throw ServerException(message: e.toString());
    }
  }
}
