import 'package:flutter/material.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/{{name}}/{{name}}_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';

/// Sheet widget for the {{name.sentenceCase()}} feature
class {{name.pascalCase()}}Sheet extends StatelessWidget
    with ControllerProvider<{{name.pascalCase()}}Controller> {
  /// Default constructor for the {{name.pascalCase()}}Sheet.
  const {{name.pascalCase()}}Sheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SizedBox.shrink(),
      ),
    );
  }
}
