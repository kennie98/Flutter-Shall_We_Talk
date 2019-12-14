import 'package:shall_we_talk/services/auth.dart';
import 'package:shall_we_talk/shared/loading.dart';
import 'package:shall_we_talk/shared/global_style.dart' as global_style;
import 'package:flutter/material.dart';

bool _loading = false;

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    global_style.setPortrait();
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(global_style.color6),
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            body: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                    ),
                    Container(
                      height: 100,
                      child: Center(
                          child: Image(
                        image: AssetImage("images/shallWeTalk.png"),
                        fit: BoxFit.scaleDown,
                        width: 300.0,
                      )),
                    ),
                    Container(
                      height: 50,
                    ),
                    LoginBlock(),
                    Container(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 60,
                        right: 60,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              global_style.styledRaisedButton(
                                'New Account',
                                () => widget.toggleView(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class LoginBlock extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginBlock> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool _autoValidate = false;
  String _username;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(50, 20, 50, 0),
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.amber, //(global_style.color5),
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: FormUI(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget FormUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          style: global_style.ts,
          decoration: const InputDecoration(
            labelText: 'Username',
            helperText: '',
            icon: Icon(Icons.account_circle),
          ),
          keyboardType: TextInputType.text,
          validator: _validateUsername,
          onSaved: (String val) {
            _username = val;
          },
        ),
        new SizedBox(
          height: 10.0,
        ),
        new TextFormField(
          style: global_style.ts,
          decoration: const InputDecoration(
            labelText: 'Password',
            helperText: '',
            icon: Icon(Icons.vpn_key),
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: _validatePassword,
          obscureText: true,
          onSaved: (String val) {
            _password = val;
          },
        ),
        new SizedBox(
          height: 30.0,
        ),
        global_style.styledRaisedButton('Login', _validateInputs),
      ],
    );
  }

  String _validateUsername(String value) {
    Pattern pattern = r'^[a-zA-Z0-9]*$';
    RegExp regex = new RegExp(pattern);

    if (value.length < 3)
      return 'Must be more than 2 charaters';
    else if (!regex.hasMatch(value))
      return 'Must not contain space or special character';
    else
      return null;
  }

  String _validatePassword(String value) {
    if (value.length < 6)
      return 'Length cannot be less than 6';
    else
      return null;
  }

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _loading = true;
      });
      dynamic result = await _auth.signInWithEmailAndPassword(
          _username + '${global_style.emailDomain}', _password);
      if (result == null) {
        global_style.showMessageDialog(context, 'Wrong credentials');
      }
      setState(() {
        _loading = false;
      });
    }
  }
}
