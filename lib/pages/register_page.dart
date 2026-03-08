import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tccflutter/exceptions/bad_request_exception.dart';
import 'package:tccflutter/exceptions/unauthorized_exception.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  @override
  void dispose() {
    _focusNodeEmail.removeListener(() {});
    _focusNodeEmail.dispose();

    _focusNodePassword.removeListener(() {});
    _focusNodePassword.dispose();

    _focusNodeName.removeListener(() {});
    _focusNodeName.dispose();

    super.dispose();
  }

  Future<void> _login() async {
    if (isDisabled) {
      return;
    }

    final navigator = Navigator.of(context);
    final localizations = AppLocalizations.of(context);

    isDisabled = true;

    try {
      await AuthStore().login(_emailController.value.text, _passwordController.value.text);

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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
                    focusNode: _focusNodeEmail,
                    validator: _emailValidator,
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    onSubmitted: _login,
                  ),
                  const SizedBox(height: 16.0),
                  InputText(
                    AppLocalizations.of(context)!.email,
                    focusNode: _focusNodeEmail,
                    validator: _emailValidator,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onSubmitted: _login,
                  ),
                  const SizedBox(height: 16.0),
                  InputText(
                    AppLocalizations.of(context)!.password,
                    focusNode: _focusNodePassword,
                    validator: _passwordValidator,
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    onSubmitted: _login,
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
                      onPressed: _login,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        child: Text(
                          AppLocalizations.of(context)!.email,
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
          ]
        ),
      ),
    );
  }
}