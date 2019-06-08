import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:flutter/material.dart';

List<Widget> buildProfileDataSection<T>({
  List<T> data,
  Widget Function(T data) builder,
  bool isLoading,
  VoidCallback onRefresh,
}) {
  if (data == null && isLoading) {
    return [
      SizedBox(height: 64.0),
      CircularProgressRevealWidget(
        color: Colors.indigo,
      )
    ];
  } else if (data == null && !isLoading) {
    return [
      SizedBox(height: 64.0),
      IconButton(
        icon: Icon(Icons.refresh),
        iconSize: 36.0,
        onPressed: onRefresh,
      )
    ];
  } else if (data != null && !isLoading) {
    return data
        .map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0), child: builder(item)))
        .toList();
  }
  return [];
}
