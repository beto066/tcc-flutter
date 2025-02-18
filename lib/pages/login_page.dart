import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tccflutter/exceptions/bad_request_exception.dart';
import 'package:tccflutter/exceptions/unauthorized_exception.dart';
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
  bool isDisabled = false;
  String? message;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  @override
  void initState() {
    super.initState();
    callbackFocusNode() {
      if (_focusNodeEmail.hasFocus || _focusNodePassword.hasFocus) {
        RawKeyboard.instance.addListener(_handleKeyPress);
      } else {
        RawKeyboard.instance.removeListener(_handleKeyPress);
      }
    }

    _focusNodeEmail.addListener(callbackFocusNode);
    _focusNodePassword.addListener(callbackFocusNode);
  }

  @override
  void dispose() {
    _focusNodeEmail.removeListener(() {});
    _focusNodeEmail.dispose();

    _focusNodePassword.removeListener(() {});
    _focusNodePassword.dispose();

    super.dispose();
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      _login();
    }
  }

  Future<void> _login() async {
    if (isDisabled) {
      return;
    }

    isDisabled = true;

    try {
      await AuthStore().login(_emailController.value.text, _passwordController.value.text);

      Navigator.of(context).popAndPushNamed('Home');
    } on BadRequestException catch (exception) {
      message = exception.message;
    } on UnauthorizedException catch (_) {
      message = 'Email ou senha incorreto';
    } catch (exception) {
      message = 'Ocorreu um erro inesperado';
      if (kDebugMode) {
        print(exception);
      }
    } finally {
      isDisabled = false;
    }
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu email';
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Por favor, insira um email válido';
    }

    return null;
  }

  String? _passwordValidator(String? value) {
    if (message != null && message!.isNotEmpty) {
      return message;
    }

    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha';
    }

    if (value.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
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
                    'Email',
                    focusNode: _focusNodeEmail,
                    validator: _emailValidator,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),
                  InputText(
                    'Senha',
                    focusNode: _focusNodePassword,
                    validator: _passwordValidator,
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.inversePrimary),
                      ),
                      onPressed: _login,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        child: const Text(
                          'Login',
                          style: TextStyle(
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