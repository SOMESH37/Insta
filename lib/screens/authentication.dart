import '../helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn gSignUp =
    GoogleSignIn(scopes: ['email', 'profile', 'https://www.googleapis.com/auth/contacts.readonly']);
GoogleSignInAccount cAccount;
bool isGoogle = false;
Map<String, String> formData = {
  'email': null,
  'password': null,
  'name': null,
  'userName': null,
  'rePwd': null,
};

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    gSignUp.disconnect();
    gSignUp.onCurrentUserChanged.listen((event) {
      print(event);
    });
  }

  @override
  Widget build(BuildContext contxt) {
    return Builder(
      // yes, it is necessary :/
      builder: (context) {
        screenH = MediaQuery.of(context).size.height;
        screenW = MediaQuery.of(context).size.width;
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                resourceHelper[2],
                height: 170,
              ),
              SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: isGoogle,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Hero(
                          tag: 'toSignG',
                          child: ElevatedButton(
                            onPressed: () async {
                              await gSignUp.signIn();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 25),
                                  child: Image.asset(
                                    resourceHelper[3],
                                    height: 28,
                                  ),
                                ),
                                Text('Sign up using Google'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Hero(
                      tag: 'toSignUp',
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: Icon(
                                Icons.mail,
                                size: 30,
                              ),
                            ),
                            Text('Sign up using Email'),
                          ],
                        ),
                      ),
                    ),
                    MyDivider(),
                    Hero(
                      tag: 'toLogin',
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LogIn(),
                            ),
                          );
                        },
                        child: Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AbsorbPointer(
            absorbing: isLoad,
            child: Column(
              children: [
                SizedBox(height: screenH * 0.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Image.asset(
                        resourceHelper[2],
                        height: 34,
                      ),
                    ),
                    Text(
                      'Welcome to $kAppName',
                      style:
                          Theme.of(context).textTheme.headline5.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: screenH * 0.12),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Email',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      buildTextFields(context, 1),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Password',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      buildTextFields(context, 2),
                    ],
                  ),
                ),
                SizedBox(height: screenH * 0.05),
                Hero(
                  tag: 'toSignUp',
                  child: RaisedButton(
                    onPressed: () async {
                      if (!_formKey.currentState.validate() || isLoad) return;
                      // TODO: toDelete
                      print(formData);
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        isLoad = true;
                      });
                      int res = await Provider.of<Auth>(context, listen: false)
                          .signUp(formData['email'], formData['password']);
                      if (res > -10 && mounted) {
                        setState(() {
                          isLoad = false;
                        });
                        if (res == 200)
                          otp(context, 1);
                        else if (res == 400 || res == 406)
                          showMyDialog(context, 'Email already in use!');
                        else
                          showMyDialog(context, 'Something went wrong');
                      }
                    },
                    child: isLoad ? myProgressIndicator() : Text('Next'),
                  ),
                ),
                SizedBox(height: screenH * 0.12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LogIn(),
                          ),
                        );
                      },
                      child: Text(
                        'Log in',
                        style:
                            Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.blue[600]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AbsorbPointer(
            absorbing: isLoad,
            child: Column(
              children: [
                SizedBox(height: screenH * (isGoogle ? 0.12 : 0.2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Image.asset(
                        resourceHelper[2],
                        height: 34,
                      ),
                    ),
                    Text(
                      'Welcome back to $kAppName',
                      style:
                          Theme.of(context).textTheme.headline5.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: screenH * (isGoogle ? 0.1 : 0.12)),
                Visibility(
                  visible: isGoogle,
                  child: Column(
                    children: [
                      Hero(
                        tag: 'toSignG',
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Image.asset(
                                  resourceHelper[3],
                                  height: 28,
                                ),
                              ),
                              Text('Login using Google'),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: MyDivider(),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'User name/ Email',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      buildTextFields(context, 6),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Password',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      buildTextFields(context, 2),
                      SizedBox(height: screenH * 0.012),
                      Hero(
                        tag: 'toFPwd',
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ForgotPwd(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot password?',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenH * 0.04),
                Hero(
                  tag: 'toLogin',
                  child: RaisedButton(
                    onPressed: () async {
                      if (!_formKey.currentState.validate() || isLoad) return;
                      // TODO: toDelete
                      print(formData);
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        isLoad = true;
                      });
                      int res = await Provider.of<Auth>(context, listen: false)
                          .login(formData['userName'], formData['password']);
                      if (res > -10 && mounted) {
                        setState(() {
                          isLoad = false;
                        });
                        if (res == 200)
                          // TODO: Entry point login
                          return;
                        else if (res == 300) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SetProfile(),
                            ),
                          );
                          showMyDialog(context, 'Please complete your profile');
                        } else if (res == 400)
                          showMyDialog(context, 'Password is incorrect!');
                        else if (res == 404)
                          showMyDialog(context, 'User not found');
                        else if (res == 406) {
                          otp(context, 1);
                          toast(context, 'Please verify your account!');
                        } else
                          showMyDialog(context, 'Something went wrong');
                      }
                    },
                    child: isLoad ? myProgressIndicator() : Text('Login'),
                  ),
                ),
                SizedBox(height: screenH * (isGoogle ? 0.05 : 0.12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New user? ',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style:
                            Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.blue[600]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPwd extends StatefulWidget {
  @override
  _ForgotPwdState createState() => _ForgotPwdState();
}

class _ForgotPwdState extends State<ForgotPwd> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: screenH * 0.04),
              Hero(
                tag: 'toFPwd',
                child: Icon(
                  Icons.mark_email_read_outlined,
                  size: 100,
                  color: Theme.of(context).textTheme.headline4.color,
                ),
              ),
              Text('Reset password', style: Theme.of(context).textTheme.headline4),
              SizedBox(height: screenH * 0.08),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 1),
                      child: Text(
                        'User name/ Email',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    buildTextFields(context, 6)
                  ],
                ),
              ),
              SizedBox(height: screenH * 0.016),
              RaisedButton(
                onPressed: () async {
                  if (!_formKey.currentState.validate() || isLoad) return;
                  FocusScope.of(context).requestFocus(FocusNode());
                  // TODO: toDelete
                  print(formData);
                  setState(() {
                    isLoad = true;
                  });
                  int res = await Provider.of<Auth>(context, listen: false)
                      .forgotPwd(formData['userName']);
                  if (res > -10 && mounted) {
                    setState(() {
                      isLoad = false;
                    });
                    if (res == 200)
                      otp(context, 2);
                    else if (res == 404)
                      showMyDialog(context, 'User not found');
                    else
                      showMyDialog(context, 'Something went wrong');
                  }
                },
                child: isLoad ? myProgressIndicator() : Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPwd extends StatefulWidget {
  @override
  _ResetPwdState createState() => _ResetPwdState();
}

class _ResetPwdState extends State<ResetPwd> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: screenH * 0.04),
              Icon(
                Icons.vpn_key_outlined,
                size: 100,
                color: Theme.of(context).textTheme.headline4.color,
              ),
              Text('Create new password', style: Theme.of(context).textTheme.headline4),
              SizedBox(height: screenH * 0.1),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'New password',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    buildTextFields(context, 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Confirm password',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    buildTextFields(context, 5),
                  ],
                ),
              ),
              SizedBox(height: screenH * 0.03),
              RaisedButton(
                onPressed: () async {
                  if (!_formKey.currentState.validate() || isLoad) return;
                  // TODO: toDelete
                  print(formData);
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    isLoad = true;
                  });
                  // TODO: reset password
                  // int res = await Provider.of<Auth>(context, listen: false)
                  //     .resetPwd(formData['email'], formData['password']);
                  // if (res > -10 && mounted) {
                  //   setState(() {
                  //     isLoad = false;
                  //   });
                  // if (res == 200)
                  //   otp(context, 1);
                  // else if (res == 400 || res == 406)
                  //   showMyDialog(context, 'Email already in use!');
                  // else
                  //   showMyDialog(context, 'Something went wrong');
                  //   }
                },
                child: isLoad ? myProgressIndicator() : Text('Create password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SetProfile extends StatefulWidget {
  @override
  _SetProfileState createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenH * 0.12, bottom: 10),
                child: Text('Account sucessfully created',
                    style: Theme.of(context).textTheme.headline6),
              ),
              Text('Please fill required details', style: Theme.of(context).textTheme.headline4),
              SizedBox(height: screenH * 0.1),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Name',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    buildTextFields(context, 3),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'User name',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    buildTextFields(context, 4),
                  ],
                ),
              ),
              SizedBox(height: screenH * 0.03),
              RaisedButton(
                onPressed: () async {
                  if (!_formKey.currentState.validate() || isLoad) return;
                  // TODO: toDelete
                  print(formData);
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    isLoad = true;
                  });
                  int res = await Provider.of<Auth>(context, listen: false)
                      .setProfile(formData['email'], formData['name'], formData['userName']);
                  if (res > -10 && mounted) {
                    setState(() {
                      isLoad = false;
                    });
                    if (res == 200)
                      // TODO: Entry point signup
                      return;
                    else if (res == 202)
                      toast(context, 'User name ${formData['userName']} is not available');
                    else if (res == 400) {
                      Navigator.pop(context);
                      showMyDialog(context, 'You are not verified!');
                    } else
                      showMyDialog(context, 'Something went wrong');
                  }
                },
                child: isLoad ? myProgressIndicator() : Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

otp(BuildContext context, int type) async {
  bool isTime = false, isLoad = false;
  String error;
  int code, clock;
  Timer time, clockTimer;
  // ignore: missing_return
  Future<int> submitOTP() async {
    FocusScope.of(context).requestFocus(FocusNode());
    // email ONLY
    int res = await Provider.of<Auth>(context, listen: false).otpSignUp(formData['email'], code);

// TODO: toDelete
    print(formData);
    if (res > -10) {
      if (res == 202) {
        if (type == 1) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SetProfile(),
            ),
          );
        } else if (type == 2) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ResetPwd(),
            ),
          );
        }
        return 0;
      } else if (res == 400) {
        return 1;
      } else {
        toast(context, 'Can\'t establish any connection');
        return 2;
      }
    }
  }

  return showModalBottomSheet(
    isDismissible: false,
    enableDrag: false,
    // @important
    isScrollControlled: true,
    elevation: double.infinity,
    backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
    context: context,
    clipBehavior: Clip.hardEdge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (cxt, reset) {
          decreaseClock() {
            if (clock > 0) {
              reset(() {
                clock--;
              });
              clockTimer = Timer(Duration(seconds: 1), () {
                decreaseClock();
              });
            }
          }

          return AbsorbPointer(
            absorbing: isLoad,
            child: AnimatedPadding(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
              // @important
              padding:
                  EdgeInsets.fromLTRB(75, 30, 75, MediaQuery.of(context).viewInsets.bottom + 30),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 22,
                children: [
                  Text('OTP verification', style: Theme.of(context).textTheme.headline4),
                  Column(
                    children: [
                      Text(
                        'OTP has been sent to',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          formData['email']
                              .toString()
                              .replaceAll(RegExp(r'(?<=.{1}).(?=.*@)'), '*'),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Incorrect? ',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (type == 1)
                                _emailController.clear();
                              else if (type == 2) _uNameController.clear();
                              if (time != null) time.cancel();
                              if (clockTimer != null) clockTimer.cancel();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Change it',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(color: Colors.blue[600]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  PinCodeTextField(
                    onCompleted: (value) async {
                      if (isLoad) return;
                      reset(() {
                        isLoad = true;
                      });
                      int rep = await submitOTP();
                      if (rep > -5) {
                        isLoad = false;
                        if (rep == 1) error = 'Incorrect OTP';
                        reset(() {});
                      }
                    },
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) => error,
                    enableActiveFill: true,
                    cursorColor: Theme.of(context).scaffoldBackgroundColor,
                    pinTheme: PinTheme(
                      borderRadius: BorderRadius.circular(8),
                      shape: PinCodeFieldShape.box,
                      fieldWidth: 65,
                      fieldHeight: 65,
                      activeColor: Colors.transparent,
                      disabledColor: Colors.transparent,
                      inactiveColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                      activeFillColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                      inactiveFillColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                      selectedFillColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                    ),
                    appContext: context,
                    length: 4,
                    onChanged: (value) {
                      code = int.tryParse(value);
                      if (error != null)
                        reset(() {
                          error = null;
                        });
                    },
                    animationType: AnimationType.scale,
                    autoFocus: true,
                    backgroundColor: Colors.transparent,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[0-9]'),
                      ),
                    ],
                    beforeTextPaste: (pasteTxt) {
                      if (int.tryParse(pasteTxt) != null && pasteTxt.length == 4)
                        return true;
                      else
                        return false;
                    },
                    keyboardType: TextInputType.number,
                    textStyle:
                        Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w700),
                    pastedTextStyle:
                        Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.w700),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if (code == null || error != null || code <= 999 || isLoad) return;
                      reset(() {
                        isLoad = true;
                      });
                      int rep = await submitOTP();
                      if (rep > -5) {
                        isLoad = false;
                        if (rep == 1) error = 'Incorrect OTP';
                        reset(() {});
                      }
                    },
                    child: isLoad ? myProgressIndicator() : Text('Verify'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: GestureDetector(
                      onTap: isTime
                          ? null
                          : () {
                              isTime = true;
                              clock = 41;
                              decreaseClock();
                              time = Timer(
                                Duration(seconds: 40),
                                () {
                                  isTime = false;
                                  clock = 0;
                                  reset(() {});
                                },
                              );
                              Provider.of<Auth>(context, listen: false)
                                  .resendOtp(formData['email']);
                            },
                      child: Text(
                        isTime ? '00:$clock' : 'Resend OTP',
                        style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

var _emailController = TextEditingController();
var _uNameController = TextEditingController();

buildTextFields(BuildContext context, int type) {
/*types:
  1 for email
  2 for password
  3 for name
  4 for username
  5 for confirm password
  6 for email/username
  enum would have been better...nah*/
  String hintTxt(type) {
    switch (type) {
      case 1:
        return 'Enter your email';
      case 2:
        return 'Enter your password';
      case 3:
        return 'What\'s your good name';
      case 4:
        return 'Unique username';
      case 5:
        return 'Re-enter password';
      case 6:
        return 'Enter your user name/ email';
      default:
        return '';
    }
  }

  String validators(type, value) {
    switch (type) {
      case 1:
        if (!RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(value))
          return 'Enter valid email';
        else
          return null;
        break;
      case 2:
        if (value.length < 4)
          return 'Password is too short!';
        else if (value.length > 14)
          return 'Password is too long!';
        else
          return null;
        break;
      case 3:
        if (value.isEmpty) return 'Name can\'t be empty';
        if (!RegExp(r'^[a-z A-Z]{1,20}$').hasMatch(value))
          return 'Upto 20 alphabets are allowed';
        else
          return null;
        break;
      case 4:
        if (value.isEmpty) return 'Dots and underscores are allowed';
        if (value.length > 12 || value.length < 3) return 'Allowed character range is 3-12';
        if (!RegExp(r'^[0-9a-z._]{2,12}$').hasMatch(value))
          return 'Alphabets, numbers, dots and underscores are allowed only';
        else
          return null;
        break;
      case 5:
        if (formData['password'] != formData['rePwd'])
          return 'Passwords don\'t match';
        else
          return null;
        break;
      case 6:
        if (value.isEmpty)
          return 'Invalid';
        else
          return null;
        break;
      default:
        return null;
    }
  }

  TextInputType keyboard(type) {
    switch (type) {
      case 1:
        return TextInputType.emailAddress;
      case 6:
        return TextInputType.emailAddress;
      case 2:
        return TextInputType.visiblePassword;
      case 5:
        return TextInputType.visiblePassword;
      case 3:
        return TextInputType.name;
      default:
        return TextInputType.text;
    }
  }

  saving(String value, int type) {
    switch (type) {
      case 1:
        formData['email'] = value;
        break;
      case 2:
        formData['password'] = value;
        break;
      case 3:
        formData['name'] = value;
        break;
      case 4:
        formData['userName'] = value;
        break;
      case 5:
        formData['rePwd'] = value;
        break;
      case 6:
        formData['userName'] = value;
        break;
    }
  }

  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 12),
    child: Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).scaffoldBackgroundColor,
            blurRadius: 0,
            spreadRadius: 0,
            offset: Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        textCapitalization: type == 3 ? TextCapitalization.words : TextCapitalization.none,
        controller: type == 1
            ? type == 6
                ? _uNameController
                : _emailController
            : null,
        autovalidateMode: type == 4 ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
        inputFormatters: [
          if (type == 3)
            FilteringTextInputFormatter.allow(
              RegExp('[a-z A-Z]'),
            ),
          if (type == 4)
            FilteringTextInputFormatter.allow(
              RegExp('[a-z0-9._]'),
            ),
        ],
        obscureText: type == 2 || type == 5,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
          // prevents jumping
          helperText: '',
          hintText: hintTxt(type),
          errorStyle: type == 4 ? TextStyle().copyWith(color: Colors.blue[800]) : TextStyle(),
        ),
        keyboardType: keyboard(type),
        validator: (value) => validators(type, value),
        onChanged: (ha) => saving(ha, type),
      ),
    ),
  );
}

Widget myProgressIndicator() {
  return Container(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation(Colors.white),
      strokeWidth: 2,
    ),
  );
}

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'or',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Expanded(
          child: Divider(),
        ),
      ],
    );
  }
}
