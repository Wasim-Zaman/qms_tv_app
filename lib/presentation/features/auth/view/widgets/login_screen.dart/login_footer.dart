import 'package:flutter/material.dart';

/// Footer text widget
class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hospital Queue Management System',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(),
      textAlign: TextAlign.center,
    );
  }
}
