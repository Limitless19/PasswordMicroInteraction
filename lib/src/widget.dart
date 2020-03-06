import 'package:flutter/material.dart';
import 'bloc/bloc.dart';

class PasswordMicroInteractionField extends StatefulWidget {
  ///Text that suggests what sort of input the field accepts.
  final String hintText;

  ///textstyle for the textfield
  final TextStyle hintStyle;

  ///Icon to show before the textfield
  final Icon icon;

  ///An icon that appears after the editable part of the text field and after the [suffix] or [suffixText], within the decoration's containe
  final Widget suffixIcon;

///The style to use for the text being edited.
  final TextStyle fieldTextStyle;

  final InputBorder fieldBorder;

  Function(String) onChanged;

   PasswordMicroInteractionField({
    Key key,
    this.hintText = 'Password',
    this.hintStyle,
    this.icon,
    this.suffixIcon,
    this.fieldTextStyle,
    this.fieldBorder,
    this.onChanged,
  }) : super(key: key);

  @override
  _PasswordMicroInteractionFieldState createState() =>
      _PasswordMicroInteractionFieldState();
}

class _PasswordMicroInteractionFieldState
    extends State<PasswordMicroInteractionField>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _fadeAnimation;
  bool makeTextObscure = true;

  static RegExp _specialCharactersExp = RegExp(r"[$&+,:;=?@#|'<>.^*()%!-]");
  static RegExp _upperCaseExp = RegExp("[A-Z]");
  static RegExp _numberExp = RegExp("[0-9]");

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      upperBound: 1.0,
      duration: Duration(milliseconds: 700),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildPasswordInteractionContainer(context: context),
        SizedBox(height: 50),
        StreamBuilder<String>(
            stream: loginBloc.firstPasswordInput,
            initialData: '',
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (loginBloc.lastPasswordValue.length >= 1) {
                _controller.forward();
              } else if (loginBloc.lastPasswordValue.length < 1) {
                _controller.reverse();
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  style: widget.fieldTextStyle != null
                      ? widget.fieldTextStyle
                      : TextStyle(color: Colors.black54),
                  obscureText: makeTextObscure,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    errorText: snapshot.error,
                    hintStyle:
                        widget.hintStyle != null ? widget.hintStyle : null,
                    border: widget.fieldBorder != null
                        ? widget.fieldBorder
                        : InputBorder.none,
                    icon: widget.icon != null
                        ? widget.icon
                        : Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                    suffixIcon: widget.suffixIcon != null
                        ? widget.suffixIcon
                        : InkWell(
                            onTap: () {
                              setState(() {
                                makeTextObscure = !makeTextObscure;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                              color:
                                  makeTextObscure ? Colors.blue : Colors.grey,
                            ),
                          ),
                  ),
                  onChanged: (passwordValue) {
                    loginBloc.changeFirstPasswordInput(passwordValue);
                    widget.onChanged(loginBloc.lastPasswordValue);
                    if (passwordValue.contains(_specialCharactersExp)) {
                      loginBloc.containsSpecialCharacters(true);
                    } else {
                      loginBloc.containsSpecialCharacters(false);
                    }
                    if (passwordValue.contains(_upperCaseExp)) {
                      loginBloc.containsUpperCaseCharacter(true);
                    } else {
                      loginBloc.containsUpperCaseCharacter(false);
                    }
                    if (passwordValue.contains(_numberExp)) {
                      loginBloc.containsDigits(true);
                    } else {
                      loginBloc.containsDigits(false);
                    }
                    if (passwordValue.length >= 6) {
                      loginBloc.isGreaterThan5(true);
                    } else {
                      loginBloc.isGreaterThan5(false);
                    }
                  },
                ),
              );
            }),
      ],
    );
  }

  Widget _buildPasswordInteractionContainer({BuildContext context}) {
    return StreamBuilder(
        stream: loginBloc.firstPasswordInput,
        builder: (context, snapshot) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 5.0,
              child: Container(
                height: 150,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    PasswordInteractionInfoElement(
                        stream: loginBloc.greaterThan6Stream,
                        infoText: '6 characters'),
                    Divider(),
                    PasswordInteractionInfoElement(
                        stream: loginBloc.specialCharactersStream,
                        infoText: '1 special character'),
                    Divider(),
                    PasswordInteractionInfoElement(
                        stream: loginBloc.digitsStream, infoText: '1 Number'),
                    Divider(),
                    PasswordInteractionInfoElement(
                        stream: loginBloc.upperCaseStream,
                        infoText: '1 UpperCase'),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class PasswordInteractionInfoElement extends StatelessWidget {
  const PasswordInteractionInfoElement({
    Key key,
    @required this.stream,
    @required this.infoText,
  }) : super(key: key);

  final Stream<bool> stream;
  final String infoText;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: stream,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeIn,
              child: Center(
                child: (!snapshot.data)
                    ? Text('$infoText', style: TextStyle(fontSize: 12))
                    : Container(
                        height: 8,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                      ),
              ),
            ),
          );
        });
  }
}
