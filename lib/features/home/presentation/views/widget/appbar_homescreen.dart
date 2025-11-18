import 'package:flutter/material.dart';
import 'package:smartcare/features/settings/presentation/views/setting_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE9F7F1),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF1B8A6F).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.filter_list, color: Color(0xFF1B8A6F)),
                    ),

                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),
              _iconCircle(Icons.shopping_cart_outlined),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingScreen()),
                  );
                },
                child: _iconCircle(Icons.settings),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "Hello To Smart Care",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B8A6F),
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            "How can we help you stay healthy today?",
            style: TextStyle(fontSize: 14, color: Color(0xFF2AAE8A)),
          ),
        ],
      ),
    );
  }

  Widget _iconCircle(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Icon(icon, size: 20, color: const Color(0xFF2AAE8A)),
    );
  }
}
