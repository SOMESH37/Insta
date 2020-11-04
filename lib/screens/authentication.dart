import '../helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LandingPage extends StatelessWidget {
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
                resourceHelper[0],
                height: 170,
              ),
              SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Hero(
                        tag: 'toSignG',
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Image.asset(
                                  resourceHelper[1],
                                  height: 30,
                                ),
                              ),
                              Text('Sign up using Google'),
                            ],
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

Map<String, String> formData = {
  'email': null,
  'password': null,
  'name': null,
  'userName': null,
  'rePwd': null,
};

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              SizedBox(height: screenH * 0.2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Image.asset(
                      resourceHelper[0],
                      height: 34,
                    ),
                  ),
                  Text(
                    'Welcome to $kAppName',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.grey[600]),
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
                  onPressed: () {
                    if (!_formKey.currentState.validate()) return;
                    print(formData);
                    otp(context);
                  },
                  child: Text('Next'),
                ),
              ),
              SizedBox(height: screenH * 0.14),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              SizedBox(height: screenH * 0.12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Image.asset(
                      resourceHelper[0],
                      height: 34,
                    ),
                  ),
                  Text(
                    'Welcome back to $kAppName',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(height: screenH * 0.1),
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
                          resourceHelper[1],
                          height: 30,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ForgetPwd(),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'toFPwd',
                        child: Text(
                          'Forget password?',
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
                  onPressed: () {
                    if (!_formKey.currentState.validate()) return;
                    print(formData);
                  },
                  child: Text('Login'),
                ),
              ),
              SizedBox(height: screenH * 0.06),
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
        ),
      ),
    );
  }
}

class ForgetPwd extends StatefulWidget {
  @override
  _ForgetPwdState createState() => _ForgetPwdState();
}

class _ForgetPwdState extends State<ForgetPwd> {
  GlobalKey<FormState> _formKey = GlobalKey();
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
              Text('Reset password',
                  style: Theme.of(context).textTheme.headline4),
              SizedBox(height: screenH * 0.08),
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
                    buildTextFields(context, 1)
                  ],
                ),
              ),
              Hero(
                tag: 'toRePwd',
                child: RaisedButton(
                  onPressed: () {
                    if (!_formKey.currentState.validate()) return;
                    print(formData);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ResetPwd(),
                      ),
                    );
                  },
                  child: Text('Next'),
                ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              SizedBox(height: screenH * 0.04),
              Hero(
                tag: 'toFPwd',
                child: Icon(
                  Icons.vpn_key_outlined,
                  size: 100,
                  color: Theme.of(context).textTheme.headline4.color,
                ),
              ),
              Text('Create new password',
                  style: Theme.of(context).textTheme.headline4),
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
              Hero(
                tag: 'toRePwd',
                child: RaisedButton(
                  onPressed: () {
                    if (!_formKey.currentState.validate()) return;
                    print(formData);
                  },
                  child: Text('Create password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

otp(BuildContext context) async {
  bool isL = false;
  int code;
  return showModalBottomSheet(
    isDismissible: false,
    enableDrag: false,
    elevation: double.infinity,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    context: context,
    clipBehavior: Clip.hardEdge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, reset) {
          return Container(
            height: 200,
          );
        },
      );
    },
  );
}

buildTextFields(BuildContext context, int type) {
/*types:
  1 for email
  2 for password
  3 for name
  4 for username
  5 for confirm password
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
        if (!RegExp(r'^[A-Z][a-z A-Z]{1,20}$').hasMatch(value))
          return 'Only 20 alphabets are allowed';
        else
          return null;
        break;
      case 4:
        if (value.isEmpty) return 'Dots and underscores are allowed';
        if (value.length > 12 || value.length < 2)
          return 'Allowed character range is 2-12';
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
      default:
        return null;
    }
  }

  TextInputType keyboard(type) {
    switch (type) {
      case 1:
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
    }
  }

  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 25),
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
        autovalidateMode: type == 4
            ? AutovalidateMode.always
            : AutovalidateMode.onUserInteraction,
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
          hintText: hintTxt(type),
          errorStyle: type == 4
              ? TextStyle().copyWith(color: Colors.blue[800])
              : TextStyle(),
        ),
        keyboardType: keyboard(type),
        validator: (value) => validators(type, value),
        onChanged: (ha) => saving(ha, type),
      ),
    ),
  );
}

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'or',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
