import 'package:flutter/material.dart';
import 'package:jejuya/app/layers/presentation/components/pages/{{name}}/{{name}}_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Page widget for the {{name.sentenceCase()}} feature
class {{name.pascalCase()}}Page extends StatelessWidget
    with ControllerProvider<{{name.pascalCase()}}Controller> {
  /// Default constructor for the {{name.pascalCase()}}Page.
  const {{name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SizedBox.shrink(),
      ),
    );
  }
}
