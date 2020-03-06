import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:passwordmicrointeraction/src/mixin/validator_mixin.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Object with LoginValidationMixin {
  // final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  final _specialCharactersController = PublishSubject<bool>();
  final _upperCaseController = PublishSubject<bool>();
  final _digitsController = PublishSubject<bool>();
  final _greaterThanNumberController = PublishSubject<bool>();


//streams
  // Observable<String> get email =>
  //     _emailController.stream.transform(validateEmail);
  Observable<String> get firstPasswordInput =>
      _passwordController.stream.transform(validatePassword);

  Observable<bool> get specialCharactersStream =>
      _specialCharactersController.stream ?? false;
  Observable<bool> get upperCaseStream => _upperCaseController.stream ?? false;
  Observable<bool> get digitsStream => _digitsController.stream ?? false;
  Observable<bool> get greaterThan6Stream =>
      _greaterThanNumberController.stream ?? false;


//sinks
  // Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeFirstPasswordInput => _passwordController.sink.add;

  Function(bool) get containsSpecialCharacters =>
      _specialCharactersController.sink.add;
  Function(bool) get containsUpperCaseCharacter =>
      _upperCaseController.sink.add;
  Function(bool) get containsDigits => _digitsController.sink.add;
  Function(bool) get isGreaterThan5 => _greaterThanNumberController.sink.add;

//last value.
  String get lastPasswordValue => _passwordController.value ?? '';

  submit() {
    Fluttertoast.showToast(
      backgroundColor: Colors.black54,
      msg: "Ola, can you see it?.I'm stressed out now though.",
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  dispose() {
    // _emailController.close();
    _passwordController.close();

    _specialCharactersController.close();
    _upperCaseController.close();
    _digitsController.close();
    _greaterThanNumberController.close();
  }
}
final loginBloc = LoginBloc();