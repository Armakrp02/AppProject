import 'package:flutter/material.dart';

class AgeInfoPage extends StatefulWidget {
  const AgeInfoPage({super.key});

  @override
  State<AgeInfoPage> createState() => _AgeInfoPageState();
}

class _AgeInfoPageState extends State<AgeInfoPage> {
  final TextEditingController _ageController = TextEditingController();
  bool _isValid = false;

  void _validateAge() {
    final age = int.tryParse(_ageController.text.trim());
    setState(() {
      _isValid = age != null && age >= 3 && age <= 120;
    });
  }

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_validateAge);
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.blue),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.75,
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.green,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              const Center(
                child: Text(
                  "How old are you?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                ),
                keyboardType: TextInputType.number,
              ),
              const Spacer(),
              // ปุ่ม NEXT
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isValid
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Age accepted!")),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isValid ? Colors.blue : Colors.grey.shade200,
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
