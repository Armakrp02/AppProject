import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 8),

          // รูปโปรไฟล์ + Add
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('lib/assets/avatar.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.edit, size: 16, color: Colors.blue),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 24),
              Column(
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFFF0F0F0),
                    child: Icon(Icons.add, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text('Add', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Teodor',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),

          const SizedBox(height: 24),
          const Text('General', style: TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 12),
          _settingButton('FAQ', onTap: () {}),
          _settingButton('GIVE US FEEDBACK', onTap: () {}),

          const SizedBox(height: 24),
          const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height: 12),
          _notificationRow('Practice reminder'),
          _notificationRow('Weekly progress'),
          _notificationRow('Learning tips & support'),
          _notificationRow('News & promotions'),

          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // sign out logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Signed out")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'SIGN OUT ARMPRYT@GMAIL.COM',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _settingButton(String title, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _notificationRow(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Row(
            children: const [
              Icon(Icons.email_outlined, color: Colors.lightBlue),
              SizedBox(width: 8),
              Icon(Icons.phone_android, color: Colors.lightBlue),
            ],
          )
        ],
      ),
    );
  }
}
