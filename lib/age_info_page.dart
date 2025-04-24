import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'choose_avatar_page.dart';
import 'home_page.dart';

class AgeInfoPage extends StatefulWidget {
  const AgeInfoPage({super.key});

  @override
  State<AgeInfoPage> createState() => _AgeInfoPageState();
}

class _AgeInfoPageState extends State<AgeInfoPage> {
  late final TextEditingController _ageController;
  late final TextEditingController _nameController;
  bool _isValid = false;

  void _validateInputs() {
    final name = _nameController.text.trim();
    final ageText = _ageController.text.trim();
    final age = int.tryParse(ageText);
    setState(() {
      _isValid = name.isNotEmpty && age != null && age >= 3 && age <= 120;
    });
  }

  @override
  void initState() {
    super.initState();
    _ageController = TextEditingController();
    _nameController = TextEditingController();
    _ageController.addListener(_validateInputs);
    _nameController.addListener(_validateInputs);
  }

  @override
  void dispose() {
    _ageController.removeListener(_validateInputs);
    _nameController.removeListener(_validateInputs);
    _ageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveNameAndAge(String name, String age) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', name);
    await prefs.setString('age', age);
  }

  void _goToAvatarSelection() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();

    await _saveNameAndAge(name, age);

    if (!mounted) return;

    final selectedAvatar = await Navigator.push<String>(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => ChooseAvatarPage(
          onAvatarSelected: (selected) {
            Navigator.pop(context, selected); // 🔁 คืนค่า avatar
          },
        ),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );

    if (selectedAvatar != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('avatarPath', selectedAvatar);

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => const HomePage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF4FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  "What's your name?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                ),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  "How old are you?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  hintText: 'Enter your age',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isValid ? _goToAvatarSelection : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isValid ? Colors.blue : Colors.grey.shade200,
                    foregroundColor: _isValid ? Colors.white : Colors.grey,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
