import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'activity_log_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // หน้าต่างๆ สำหรับแต่ละเลเวล
          PageView(
            scrollDirection: Axis.horizontal,
            children: const [
              LevelPage(level: 1, backgroundColor: Color(0xFFB3E5FC)),
              LevelPage(level: 2, backgroundColor: Color(0xFF90CAF9)),
              LevelPage(level: 3, backgroundColor: Color(0xFFB2EBF2)),
            ],
          ),

          // ไอคอนโปรไฟล์ (มุมซ้ายบน)
          Positioned(
            top: 40,
            left: 20,
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.person, size: 30, color: Colors.purple),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfilePage()),
                  );
                },
              ),
            ),
          ),

          // ไอคอนสมุดกิจกรรม (มุมขวาบน)
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
        ],
      ),
    );
  }
}

class LevelPage extends StatelessWidget {
  final int level;
  final Color backgroundColor;

  const LevelPage({
    super.key,
    required this.level,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Image.asset(
              'lib/assets/building_level$level.png',
              height: 400,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text(
              'LEVEL $level',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
