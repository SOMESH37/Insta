import '../helper.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<int> signUp(String email, String pwd) async {
    try {
      var response = await http.post(
        kurl + '/api/registration',
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(
          {
            "userEmail": "$email",
            "password": "$pwd",
          },
        ),
      );
      print(response.statusCode);
      print(response.body);
      // 200 not exists false
      // 406 exists false
      // 400 exists true
      return response.statusCode;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future otpSignUp(String email, int code) async {
    // email ONLY
    try {
      var response = await http.post(
        kurl + '/api/validateOTP',
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(
          {
            "email": "$email",
            "otp": "$code",
          },
        ),
      );
      print(response.statusCode);
      print(response.body);
      // 202
      // 400 wrong
      return response.statusCode;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future resendOtp(String email) async {
    try {
      var response = await http.post(
        kurl + '/api/resendOTP/$email',
        headers: {
          "Content-Type": "application/json",
        },
      );
      print(response.statusCode);
      print(response.body);
      // 200
      // 404  Email not registered!
      return response.statusCode;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future setProfile(String email, String name, String uName) async {
    try {
      var response = await http.post(
        kurl + '/api/details',
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(
          {
            "email": "$email",
            "name": "$name",
            "username": "$uName",
          },
        ),
      );
      print(response.statusCode);
      print(response.body);
      // 200
      // 202 uName exists
      // 400 Unverified user!
      return response.statusCode;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future login(String email, String pwd) async {
    try {
      var response = await http.post(
        kurl + '/api/login',
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(
          {
            "username": "$email",
            "password": "$pwd",
          },
        ),
      );
      print(response.statusCode);
      print(response.body);
      // 200
      // 406 User not verified. Please check EMAIL to verify.
      // 404 Username/Email doesn't exist!
      // 400 Password is incorrect!
      // 300 username is null
      if (response.statusCode == 202) {
      } else
        return response.statusCode;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future forgotPwd(String email) async {
    try {
      var response = await http.post(
        kurl + '/api/forgotPassword',
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(
          {
            "detail": "$email",
          },
        ),
      );
      print(response.statusCode);
      print(response.body);
      // 200  {"detail":"momox82587@appnox.com"}
      // 404  No account is registered by this email/username!
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        formData['email'] = responseData['detail'].toString();
      }
      return response.statusCode;
    } catch (error) {
      print(error);
      return -1;
    }
  }

  Future resetPwd(String email, String pwd) async {
    try {
      var response = await http.post(
        kurl + '/api/setNewPassword',
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(
          {
            "email": "$email",
            "password": "$pwd",
          },
        ),
      );
      print(response.statusCode);
      print(response.body);
      // 200  {"detail":"momox82587@appnox.com"}
      // 404  No account is registered by this email/username!
      return response.statusCode;
    } catch (error) {
      print(error);
      return -1;
    }
  }
}
