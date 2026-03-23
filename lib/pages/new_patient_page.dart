import 'package:flutter/cupertino.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/widgets/atoms/input_text.dart';

class NewPatientPage extends StatefulWidget {
  const NewPatientPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return NewPatientPageState();
  }
}

class NewPatientPageState extends State<NewPatientPage> {
  String? message;
  final minNameLength = 4;
  final maxNameLength = 30;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final FocusNode _focusNodeName = FocusNode();

  String? _nameValidator(String? value) {
    if (message != null && message!.isNotEmpty) {
      return message;
    }

    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.auth_name_required;
    }

    if (value.length < minNameLength) {
      return AppLocalizations.of(context)!.auth_name_min_length(minNameLength);
    }

    if (value.length < maxNameLength) {
      return AppLocalizations.of(context)!.auth_name_max_length(maxNameLength);
    }

    return null;
  }

  Future<void> _create() async {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InputText(
                    AppLocalizations.of(context)!.name,
                    focusNode: _focusNodeName,
                    validator: _nameValidator,
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    onSubmitted: _create,
                  ),
                  const SizedBox(height: 16.0),
                  InputText(
                    AppLocalizations.of(context)!.email,
                    focusNode: _focusNodeEmail,
                    validator: _emailValidator,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onSubmitted: _create,
                  ),
                  const SizedBox(height: 16.0),
                  InputText(
                    AppLocalizations.of(context)!.password,
                    focusNode: _focusNodePassword,
                    validator: _passwordValidator,
                    controller: _passwordController,
                    obscureText: true,
                    maxLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    onSubmitted: _create,
                  ),
                  const SizedBox(height: 16.0),
                  InputText(
                    AppLocalizations.of(context)!.confirm_password,
                    focusNode: _focusNodeConfirmPassword,
                    validator: _passwordValidator,
                    controller: _confirmPasswordController,
                    obscureText: true,
                    maxLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    onSubmitted: _create,
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: const Color(0xFFDEE2E3),
                        )
                    ),
                    child: DropdownButton<Role?>(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      style: const TextStyle(color: Colors.black),
                      borderRadius: BorderRadius.circular(30.0),
                      dropdownColor: Colors.white,
                      value: _role,
                      underline: Container(),
                      hint: Text(
                        AppLocalizations.of(context)!.role,
                        style: const TextStyle(color: Colors.black),
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      // items: items,
                      items: [
                        DropdownMenuItem<Role?>(
                          value: Role.family,
                          child: Text(AppLocalizations.of(context)!.family),
                        ),
                        DropdownMenuItem<Role?>(
                          value: Role.therapist,
                          child: Text(AppLocalizations.of(context)!.therapist),
                        ),
                      ],
                      onChanged: (Role? newValue) {
                        setState(() {
                          _role = newValue ?? Role.family;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextButton(
                      style: const ButtonStyle(
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: _redirectToLogin,
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.inversePrimary
                        ),
                      ),
                      onPressed: _create,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        child: Text(
                          AppLocalizations.of(context)!.register,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}