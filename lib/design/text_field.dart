import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModernTextField extends StatelessWidget {
  final Function(String) onChanged;
  final Function onSubmitted;
  final FocusNode focusNode;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final Widget prefix;
  final bool obscureText;
  final bool autocorrect;
  final String error;

  const ModernTextField({
    Key key,
    this.onChanged,
    this.focusNode,
    this.hintText,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefix,
    this.autocorrect = false,
    this.error,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String text) {
        onChanged(text);
        onSubmitted();
      },
      onEditingComplete: onSubmitted,
      onSubmitted: (text) => onSubmitted(),
      keyboardType: keyboardType,
      focusNode: focusNode,
      obscureText: obscureText,
      autocorrect: autocorrect,
      decoration: InputDecoration(
        errorText: error,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.black12, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width: 16.0),
            Icon(icon),
            SizedBox(width: 8.0),
            prefix ?? SizedBox(width: 4.0, height: 0.0),
            SizedBox(width: 4.0),
          ],
        ),
        hintText: hintText,
        hintStyle: ModernTextTheme.caption,
      ),
    );
  }
}
