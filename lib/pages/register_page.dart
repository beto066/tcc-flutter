import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tccflutter/exceptions/bad_request_exception.dart';
import 'package:tccflutter/exceptions/unauthorized_exception.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/enums/role.dart';
import 'package:tccflutter/stores/auth_store.dart';
import 'package:tccflutter/widgets/atoms/input_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final minLengthPassword = 6;
  final minNamePassword = 4;
  final maxNamePassword = 30;

  bool isDisabled = false;
  String? message;

  Role _role = Role.family;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();

  @override
  void dispose() {
    _focusNodeName.removeListener(() {});
    _focusNodeName.dispose();

    _focusNodeEmail.removeListener(() {});
    _focusNodeEmail.dispose();

    _focusNodePassword.removeListener(() {});
    _focusNodePassword.dispose();

    _focusNodeConfirmPassword.removeListener(() {});
    _focusNodeConfirmPassword.dispose();

    super.dispose();
  }

  Future<void> _register() async {
    if (isDisabled) {
      return;
    }

    final navigator = Navigator.of(context);
    final localizations = AppLocalizations.of(context);

    isDisabled = true;

    try {
      await AuthStore().register(
        name: _nameController.value.text,
        email: _emailController.value.text,
        password: _passwordController.value.text,
        role: _role,
      );

      if (!context.mounted) return;

      navigator.popAndPushNamed('Home');
    } on BadRequestException catch (exception) {
      message = exception.message;
    } on UnauthorizedException catch (_) {
      message = localizations!.auth_invalid_credentials;
    } catch (exception) {
      message = localizations!.unexpected_error;
      if (kDebugMode) {
        print(exception);
      }
    } finally {
      isDisabled = false;
    }
  }

  void _redirectToLogin() {
    Navigator.of(context).popAndPushNamed('Login');
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.auth_email_required;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return AppLocalizations.of(context)!.auth_invalid_email;
    }

    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.auth_password_required;
    }

    if (value.length < minLengthPassword) {
      return AppLocalizations.of(context)!.auth_password_min_length(minLengthPassword);
    }

    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value != _passwordController.value.text) {
      return AppLocalizations.of(context)!.auth_password_mismatch;
    }

    return null;
  }

  String? _nameValidator(String? value) {
    if (message != null && message!.isNotEmpty) {
      return message;
    }

    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.auth_name_required;
    }

    if (value.length < minNamePassword) {
      return AppLocalizations.of(context)!.auth_name_min_length(minNamePassword);
    }

    if (value.length < maxNamePassword) {
      return AppLocalizations.of(context)!.auth_name_max_length(maxNamePassword);
    }

    return null;
  }

  String? _typeValidator(int? value) {
    if (value != 1 && value != 2) {
      return AppLocalizations.of(context)!.unexpected_error;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    var contextWidth = MediaQuery.of(context).size.width;
    var logoWidth = MediaQuery.of(context).size.width * 0.8;
    var containerLogoHeight = MediaQuery.of(context).size.height * 0.2;

    // List<DropdownMenuItem<Role?>> items = Role.values.map((Role option) {
    //   return DropdownMenuItem<Role?>(
    //     value: option,
    //     child: Text(option.name),
    //   );
    // }).toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: containerLogoHeight,
              child: OverflowBox(
                maxHeight: logoWidth * 0.8,
                alignment: Alignment.center,
                child: SizedBox(
                  width: logoWidth * 0.8,
                  child: Center(child: Image.asset('assets/images/logo.png'))
                ),
              )
            ),
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
                    onSubmitted: _register,
                  ),
                  const SizedBox(height: 16.0),
                  InputText(
                    AppLocalizations.of(context)!.email,
                    focusNode: _focusNodeEmail,
                    validator: _emailValidator,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onSubmitted: _register,
                  ),
                  const SizedBox(height: 16.0),
                  InputText(
                    AppLocalizations.of(context)!.password,
                    focusNode: _focusNodePassword,
                    validator: _passwordValidator,
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    onSubmitted: _register,
                  ),
                  const SizedBox(height: 16.0),
                  InputText(
                    AppLocalizations.of(context)!.confirm_password,
                    focusNode: _focusNodeConfirmPassword,
                    validator: _passwordValidator,
                    controller: _confirmPasswordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    onSubmitted: _register,
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
                      onPressed: _register,
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