import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meteo/views/pages/search_page.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              readOnly: true,
              decoration: const InputDecoration(
                hintText: "Search ...",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onTap: () => Get.to(() => const SearchPage()),
            ),
          ),
        ],
      ),
    );
  }
}
