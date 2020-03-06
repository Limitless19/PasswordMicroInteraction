import 'dart:async';
import 'package:email_validator/email_validator.dart';

class LoginValidationMixin {
static RegExp _specialCharactersExp = RegExp(r"[$&+,:;=?@#|'<>.^*()%!-]");
static RegExp _upperCaseExp = RegExp("[A-Z]");
static RegExp _numberExp =  RegExp("[0-9]");


  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (EmailValidator.validate(email,true,true)) {
      sink.add(email);
    } else {
      sink.addError('Enter a  valid email');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length <= 6) {
      sink.addError("Must be greater than 6 characters.");
    } else if (!password.contains(_specialCharactersExp)) {
      sink.addError("Must contain at least a special character");
    } else if (!password.contains(_upperCaseExp)) {
      sink.addError('Must contain at least a upper case');
    } else if (!password.contains(_numberExp)) {
      sink.addError('Must contain at least a number');
    } else {
      sink.add(password);
    }
  });
}
