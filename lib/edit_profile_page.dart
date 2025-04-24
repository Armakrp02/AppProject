import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'choose_avatar_page.dart';
import 'main.dart'; // ต้องแน่ใจว่า path ถูกต้อง

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _avatarPath = 'lib/assets/avatar1.png';

  late TextEditingController _nicknameController;
  late TextEditingController _ageController;

  bool _soundEffects = true;
  bool _speakingExercises = true;
  bool _freehandedWriting = true;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController();
    _ageController = TextEditingController();

    _nicknameController.addListener(_autoSaveProfile);
    _ageController.addListener(_autoSaveProfile);

    _loadProfile();
  }

  @override
  void dispose() {
    _nicknameController.removeListener(_autoSaveProfile);
    _ageController.removeListener(_autoSaveProfile);
    _nicknameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _avatarPath = prefs.getString('avatarPath') ?? _avatarPath;
      _nicknameController.text = prefs.getString('nickname') ?? '';
      _ageController.text = prefs.getString('age') ?? '';
      _soundEffects = prefs.getBool('soundEffects') ?? true;
      _speakingExercises = prefs.getBool('speakingExercises') ?? true;
      _freehandedWriting = prefs.getBool('freehandedWriting') ?? true;
    });
  }

  void _autoSaveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', _nicknameController.text.trim());
    await prefs.setString('age', _ageController.text.trim());
  }

  Future<void> _saveToggle(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _saveAvatarPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatarPath', path);
  }

  void _signOut() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const DuolingoHomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 12),

            if (_avatarPath != 'lib/assets/avatar1.png') ...[
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(_avatarPath),
                ),
              ),
              const SizedBox(height: 8),
            ],

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChooseAvatarPage(
                        onAvatarSelected: (selected) {
                          _saveAvatarPath(selected);
                          setState(() {
                            _avatarPath = selected;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
                child: const Text("CHANGE AVATAR", style: TextStyle(color: Colors.blue)),
              ),
            ),

            const SizedBox(height: 24),
            const Text("Nickname", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextFormField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF2F2F2),
              ),
            ),

            const SizedBox(height: 16),
            const Text("Age", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF2F2F2),
              ),
            ),

            const SizedBox(height: 32),
            const Text("General", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),

            SwitchListTile(
              title: const Text("Sound effects"),
              value: _soundEffects,
              onChanged: (value) {
                setState(() => _soundEffects = value);
                _saveToggle('soundEffects', value);
              },
              activeColor: Colors.blue,
            ),
            SwitchListTile(
              title: const Text("Speaking exercises"),
              value: _speakingExercises,
              onChanged: (value) {
                setState(() => _speakingExercises = value);
                _saveToggle('speakingExercises', value);
              },
              activeColor: Colors.blue,
            ),
            SwitchListTile(
              title: const Text("Freehanded writing"),
              value: _freehandedWriting,
              onChanged: (value) {
                setState(() => _freehandedWriting = value);
                _saveToggle('freehandedWriting', value);
              },
              activeColor: Colors.blue,
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _signOut,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('SIGN OUT', style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
