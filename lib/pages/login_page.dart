import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tccflutter/exceptions/bad_request_exception.dart';
import 'package:tccflutter/exceptions/unauthorized_exception.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/stores/auth_store.dart';
import 'package:tccflutter/widgets/atoms/input_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final minLengthPassword = 6;

  bool isDisabled = false;
  String? message;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  @override
  void dispose() {
    _focusNodeEmail.removeListener(() {});
    _focusNodeEmail.dispose();

    _focusNodePassword.removeListener(() {});
    _focusNodePassword.dispose();

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
      await AuthStore()
          .login(_emailController.value.text, _passwordController.value.text);

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

  void _redirectToRegister() {
    Navigator.of(context).popAndPushNamed('Register');
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
    if (message != null && message!.isNotEmpty) {
      return message;
    }

    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.auth_password_required;
    }

    if (value.length < minLengthPassword) {
      return AppLocalizations.of(context)!
          .auth_password_min_length(minLengthPassword);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth =
            constraints.maxWidth > constraints.maxHeight ? 960.0 : 480.0;
        final form = Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputText(
                localization.email,
                focusNode: _focusNodeEmail,
                validator: _emailValidator,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onSubmitted: _login,
              ),
              const SizedBox(height: 16),
              InputText(
                localization.password,
                focusNode: _focusNodePassword,
                validator: _passwordValidator,
                controller: _passwordController,
                obscureText: true,
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
                onSubmitted: _login,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextButton(
                  style: const ButtonStyle(
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: _redirectToRegister,
                  child: Text(
                    localization.register,
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
                onPressed: _login,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Text(
                    localization.login,
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
