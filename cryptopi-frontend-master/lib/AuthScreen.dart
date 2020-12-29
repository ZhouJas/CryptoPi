import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  final bool login;

  AuthPage({this.login});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool login = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  String specialMessage = '';

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    login = widget.login;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: Text(login ? 'Login': 'Register')
      ),
      backgroundColor: Colors.blue,
      body: Form(
        key: _formKey,
        child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(child: Text(login ? 'Welcome Back!' : 'Welcome', style: TextStyle(fontSize: 30)),),
              login ? Container() : Container(
                width: MediaQuery.of(context).size.width * 0.4 * 0.8,
                child: TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                     labelText: 'Username',
                      hintText: 'Enter your username'
                    ),
                  validator: (value) {
                    if (login) {
                      return null;
                    }

                    if (value.length < 4) {
                      return 'Username must be at least 4 characters long';
                    }

                    return null;
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4 * 0.8,
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                     labelText: 'Email',
                      hintText: 'Enter your Email'
                    ),
                  validator: (value) {
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid e-mail address';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4 * 0.8,
                child: TextFormField(
                  controller: password,
                   decoration: InputDecoration(
                     labelText: 'Password',
                      hintText: 'Enter your password'
                    ),
                  validator: (value) {
                    if (!(value.length > 7) && !login) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: FlatButton(onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (login) {
                    // Login
                  } else {
                    // Register
                  }
                }
              }, color: Colors.blue, child: Text(login ? 'Login' : 'Register', style: TextStyle(color: Colors.white),),),
              ),
              (specialMessage == '') ? Container() : Container(
                child: Text(specialMessage, style: TextStyle(color: Colors.red),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      login = !login;
                    });
                  },
                  child: Text(login ? 'Don\'t have an account? Sign up!' : 'Have an account? Log in!'),
                )
              )
            ],
          ),
        ),
      ),
      )
    );
  }
}