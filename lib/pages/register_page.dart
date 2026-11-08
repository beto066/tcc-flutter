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
      return AppLocalizations.of(context)!
          .auth_password_min_length(minLengthPassword);
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
      return AppLocalizations.of(context)!
          .auth_name_min_length(minNamePassword);
    }

    if (value.length < maxNamePassword) {
      return AppLocalizations.of(context)!
          .auth_name_max_length(maxNamePassword);
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
    final localization = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth =
            constraints.maxWidth > constraints.maxHeight ? 1040.0 : 520.0;
        final form = Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputText(
                localization.name,
                focusNode: _focusNodeName,
                validator: _nameValidator,
                controller: _nameController,
                keyboardType: TextInputType.text,
                onSubmitted: _register,
              ),
              const SizedBox(height: 12),
              InputText(
                localization.email,
                focusNode: _focusNodeEmail,
                validator: _emailValidator,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onSubmitted: _register,
              ),
              const SizedBox(height: 12),
              InputText(
                localization.password,
                focusNode: _focusNodePassword,
                validator: _passwordValidator,
                controller: _passwordController,
                obscureText: true,
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
                onSubmitted: _register,
              ),
              const SizedBox(height: 12),
              InputText(
                localization.confirm_password,
                focusNode: _focusNodeConfirmPassword,
                validator: _passwordValidator,
                controller: _confirmPasswordController,
                obscureText: true,
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
                onSubmitted: _register,
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFFDEE2E3)),
                ),
                child: DropdownButton<Role?>(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  style: const TextStyle(color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                  dropdownColor: Colors.white,
                  value: _role,
                  underline: Container(),
                  hint: Text(
                    localization.role,
                    style: const TextStyle(color: Colors.black),
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  items: [
                    DropdownMenuItem<Role?>(
                      value: Role.family,
                      child: Text(localization.family),
                    ),
                    DropdownMenuItem<Role?>(
                      value: Role.therapist,
                      child: Text(localization.therapist),
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
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextButton(
                  style: const ButtonStyle(
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: _redirectToLogin,
                  child: Text(
                    localization.login,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onPressed: _register,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Text(
                    localization.register,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: contentWidth),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: LayoutBuilder(
                builder: (context, contentConstraints) {
                  final isLandscape = contentConstraints.maxWidth >
                      contentConstraints.maxHeight;
                  final logo = Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                    height:
                        (contentConstraints.maxHeight * 0.65).clamp(0.0, 220.0),
                  );
                  final scrollableForm = SingleChildScrollView(
                    child: form,
                  );

                  return isLandscape
                      ? Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(child: logo),
                            ),
                            const SizedBox(width: 32),
                            Expanded(flex: 3, child: scrollableForm),
                          ],
                        )
                      : Column(
                          children: [
                            logo,
                            const SizedBox(height: 20),
                            Expanded(child: scrollableForm),
                          ],
                        );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
