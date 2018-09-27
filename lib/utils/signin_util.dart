import 'package:google_sign_in/google_sign_in.dart';

class SignInUtil {
  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
}
