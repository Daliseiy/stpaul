import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:stpaulanglicanchurh/providers/auth_provider.dart';
import 'package:stpaulanglicanchurh/responsive.dart';

import '../../constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _username;
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  bool? _success;

  void _register() async {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    await Provider.of<AuthProvider>(context, listen: false)
        .login(_email, _password)
        .then((value) {
      setState(() {
        _isLoading = false;
        //_userEmail = user.email;
      });
      Navigator.pushNamed(context, 'dashboard');
    }).catchError((err) {
      setState(() {
        _isLoading = false;
        //_userEmail = user.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff001242),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Log in',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.white),
              ),
              SizedBox(
                height: defaultPadding * 0.5,
              ),
              Text(
                'Please sign in to continue',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
              ),
              SizedBox(
                height: Responsive.isDesktop(context)
                    ? defaultPadding * 2.5
                    : defaultPadding * 1.5,
              ),
              Center(
                child: Container(
                  //margin: EdgeInsets.all(defaultPadding),
                  width: 400,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: TextFormField(
                              initialValue: _email,
                              decoration: InputDecoration(hintText: 'E-mail'),
                              onSaved: (newValue) => _email = newValue!,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: TextFormField(
                              obscureText: true,
                              initialValue: _password,
                              decoration: InputDecoration(hintText: 'Password'),
                              onSaved: (newValue) => _password = newValue!,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xff001242),
                                  ),
                                )
                              : MaterialButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _register();
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  color: Color(0xff001242),
                                  child: Padding(
                                    padding: EdgeInsets.all(defaultPadding),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
