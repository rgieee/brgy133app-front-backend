import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});
  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String _file = "No file attached";

  void _submit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure to submit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  content: const Text("Feedback submitted successfully"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Enter message...",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => setState(() => _file = "image_attached.jpg"),
                child: const Text("Attach Image"),
              ),
              const SizedBox(width: 10),
              Text(_file),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB93413),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _submit,
              child: const Text("SUBMIT", style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
