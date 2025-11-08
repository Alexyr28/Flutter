import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fixmec/pages/ui/home.dart';
import 'package:provider/provider.dart';
import 'package:fixmec/services/localization_service.dart';

class LoginPage extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const LoginPage({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool _isLogin = true;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  Future<void> _submit() async {
    final loc = Provider.of<LocalizationService>(context, listen: false);
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    //revisar firebase auth
    try {
      if (_isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text.trim(),
        );
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeFixMec(
              isDark: widget.isDark,
              onThemeChanged: widget.onThemeChanged,
            ),
          ),
        );
        return;
      } else {
        //Registro Nuevo
        UserCredential userCred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _emailCtrl.text.trim(),
              password: _passwordCtrl.text.trim(),
            );
        //Crear documento de usuario en Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCred.user!.uid)
            .set({
              "progressoil": 0.0,
              "progesstires": 0.0,
              "progressbrakes": 0.0,
              "progresschain": 0.0,
              "progresslight": 0.0,
              'progressoilDate': null,
              'progesstiresDate': null,
              'progressbrakesDate': null,
              'progresschainDate': null,
              'progresslightDate': null,
            });
        if (!mounted) return;
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(
              loc.translate("userregok"),
              style: TextStyle(
                fontFamily: "MiFuente",
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
        setState(() {
          _isLogin = true;
        });
        _passwordCtrl.clear();
        _confirmCtrl.clear();

        return;
      }
    } on FirebaseAuthException catch (e) {
      String msg = "${loc.translate("error")}: ${e.code}";
      if (e.code == "user-not-found" || e.code == "invalid-credential") {
        msg = loc.translate("usernot");
      }
      if (e.code == "wrong-password") {
        msg = loc.translate("passwordincorrect");
      }
      if (e.code == "email-already-in-use") {
        msg = loc.translate("emailreg");
      }
      if (e.code == "invalid-email") {
        msg = loc.translate("invalidemail");
      }

      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            msg,
            style: TextStyle(
              fontFamily: "MiFuente",
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  InputDecoration _inputDeco(
    BuildContext context,
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white70),
      labelText: Provider.of<LocalizationService>(context).translate(label),
      labelStyle: const TextStyle(
        color: Colors.white70,
        fontFamily: "MiFuente",
        fontWeight: FontWeight.bold,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white38),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String text, bool isSignIn) {
    final active = (isSignIn && _isLogin) || (!isSignIn && !_isLogin);
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isLogin = isSignIn),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: active ? Colors.white.withOpacity(0.25) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            Provider.of<LocalizationService>(context).translate(text),
            style: TextStyle(
              color: active ? Colors.white : Colors.white60,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
              fontFamily: "MiFuente",
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = Provider.of<LocalizationService>(context);
    final size = MediaQuery.of(context).size;
    //visual
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF004E92), Color(0xFF00B4DB)],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
              child: Column(
                children: [
                  Image.asset(
                    "assets/icons/repair.png",
                    height: size.height * 0.14,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    loc.translate("app_name"),
                    style: TextStyle(
                      fontFamily: "MiFuente",
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    loc.translate("diag"),
                    style: const TextStyle(
                      fontFamily: "MiFuente",
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Pestañassss: Sign In / Sign Up
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _buildTabButton(context, "login", true),
                        _buildTabButton(context, "register", false),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Formulario dinámico
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailCtrl,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "MiFuente",
                          ),
                          decoration: _inputDeco(context, "email", Icons.email),
                          validator: (v) =>
                              v!.isEmpty ? loc.translate("putemail") : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "MiFuente",
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: _inputDeco(
                            context,
                            "password",
                            Icons.lock,
                          ),
                          validator: (v) =>
                              v!.length < 6 ? loc.translate("mincharac") : null,
                        ),
                        if (!_isLogin) ...[
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _confirmCtrl,
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "MiFuente",
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: _inputDeco(
                              context,
                              "confirmpass",
                              Icons.lock_outline,
                            ),
                            validator: (v) => v != _passwordCtrl.text
                                ? loc.translate("passnot")
                                : null,
                          ),
                        ],
                        const SizedBox(height: 30),
                        _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blueAccent,
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  _isLogin
                                      ? loc.translate("login")
                                      : loc.translate("register"),
                                  style: TextStyle(
                                    fontFamily: "MiFuente",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
