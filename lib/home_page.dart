import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile_page.dart';
import 'activity_log_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _avatarPath;
  int _currentPage = 0;

  final List<String> _levels = ['Level 1', 'Level 2', 'Level 3'];

  @override
  void initState() {
    super.initState();
    _loadAvatarPath();
  }

  Future<void> _loadAvatarPath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _avatarPath = prefs.getString('avatarPath') ?? 'lib/assets/avatar1.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ พื้นหลัง
          Positioned.fill(
            child: Image.asset(
              'lib/assets/BGlv1.png',
              fit: BoxFit.cover,
            ),
          ),

          // ✅ PageView สำหรับเปลี่ยนเลเวล
          PageView.builder(
            itemCount: _levels.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Text(
                  _levels[index],
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),

          // ✅ ปุ่มโปรไฟล์ (ซ้ายบน)
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfilePage()),
                ).then((_) => _loadAvatarPath());
              },
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                backgroundImage:
                    _avatarPath != null ? AssetImage(_avatarPath!) : null,
                child: _avatarPath == null
                    ? const Icon(Icons.person, color: Colors.purple)
                    : null,
              ),
            ),
          ),

          // ✅ ปุ่ม Activity log (ขวาบน)
          Positioned(
            top: 40,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.book, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ActivityLogPage()),
                  );
                },
              ),
            ),
          ),

          // ✅ Indicator แสดงว่าอยู่หน้าไหน
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _levels.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 12 : 8,
                  height: _currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}