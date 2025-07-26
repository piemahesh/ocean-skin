import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageComposer extends StatefulWidget {
  final void Function(String text, String? imagePath) onSend;
  const MessageComposer({super.key, required this.onSend});
  @override
  State<MessageComposer> createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  final _controller = TextEditingController();
  String? _imagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _imagePath = picked.path);
  }

  void _send() {
    widget.onSend(_controller.text.trim(), _imagePath);
    _controller.clear();
    setState(() => _imagePath = null);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: Icon(Icons.photo), onPressed: _pickImage),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Message...'),
          ),
        ),
        if (_imagePath != null)
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Image.file(File(_imagePath!), width: 40, height: 40),
          ),
        IconButton(icon: Icon(Icons.send), onPressed: _send),
      ],
    );
  }
}
