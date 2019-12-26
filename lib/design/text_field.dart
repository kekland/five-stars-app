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
  final String suffixText;
  final int lines;
  final bool obscureText;
  final bool autocorrect;
  final String error;
  final TextEditingController controller;
  final bool enabled;

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
    this.suffixText,
    this.lines = 1,
    this.controller,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      onChanged: (String text) {
        onChanged(text);
        if (onSubmitted != null) {
          onSubmitted();
        }
      },
      onEditingComplete: onSubmitted,
      onSubmitted: (text) => onSubmitted(),
      keyboardType: keyboardType,
      focusNode: focusNode,
      maxLines: lines,
      obscureText: obscureText,
      autocorrect: autocorrect,
      decoration: InputDecoration(
        errorText: error,
        fillColor: ModernTextTheme.captionIconColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: ModernColorTheme.main, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: ModernColorTheme.main, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide:
              BorderSide(color: Colors.black.withOpacity(0.05), width: 2.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide:
              BorderSide(color: Colors.black.withOpacity(0.05), width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: ModernColorTheme.main, width: 2.0),
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
        suffixText: suffixText,
      ),
    );
  }
}
