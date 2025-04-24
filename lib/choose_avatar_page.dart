import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseAvatarPage extends StatelessWidget {
  final Function(String) onAvatarSelected;

  ChooseAvatarPage({super.key, required this.onAvatarSelected});

  final List<String> avatarList = [
    'lib/assets/avatar1.png',
    'lib/assets/avatar2.png',
    'lib/assets/avatar3.png',
    'lib/assets/avatar4.png',
    'lib/assets/avatar5.png',
    'lib/assets/avatar6.png',
    'lib/assets/avatar7.png',
    'lib/assets/avatar8.png',
    'lib/assets/avatar9.png',
    'lib/assets/avatar10.png',
    'lib/assets/avatar11.png',
    'lib/assets/avatar12.png',
    'lib/assets/avatar13.png',
    'lib/assets/avatar14.png',
    'lib/assets/avatar15.png',
  ];

  Future<String> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nickname') ?? 'you';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: _loadName(),
          builder: (context, snapshot) {
            final name = snapshot.data ?? 'you';
            return Text(
              "Choose a character for $name",
              style: const TextStyle(color: Colors.black),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: avatarList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final avatar = avatarList[index];
            return GestureDetector(
              onTap: () {
                onAvatarSelected(avatar); // 🔁 callback → pop กลับจาก AgeInfoPage
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(avatar),
                backgroundColor: Colors.grey[200],
                radius: 40,
              ),
            );
          },
        ),
      ),
    );
  }
}
