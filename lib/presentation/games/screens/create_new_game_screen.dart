import 'package:flutter/material.dart';

import '/generated/l10n.dart';

class CreateNewGameScreen extends StatelessWidget {
  const CreateNewGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        title: Text(S.of(context).createNewGame),
      ),

      // Body
      body: SingleChildScrollView(
        child: _Form(),
      ),
    );
  }
}

// Form
class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 15,
        children: [],
      ),
    );
  }
}
