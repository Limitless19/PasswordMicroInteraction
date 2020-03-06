import 'package:flutter/material.dart';
import 'package:passwordmicrointeraction/src/widget.dart';

class PasswordMicroInteraction extends StatefulWidget {
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

  ///The form containing other fields
  final Widget form;
  
  Function(String) onChanged;

   PasswordMicroInteraction({
    Key key,
    this.hintText = 'Password',
    this.hintStyle,
    this.icon,
    this.form,
    this.suffixIcon,
    this.fieldTextStyle,
    this.fieldBorder,
    this.onChanged,
  }) : super(key: key);

  @override
  _PasswordMicroInteractionState createState() =>
      _PasswordMicroInteractionState();
}

class _PasswordMicroInteractionState extends State<PasswordMicroInteraction>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PasswordMicroInteractionField(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          icon: widget.icon,
          suffixIcon: widget.suffixIcon,
          fieldTextStyle: widget.fieldTextStyle,
          fieldBorder: widget.fieldBorder,
          onChanged: widget.onChanged,
        ),
        widget.form,
      ],
    );
  }
}
