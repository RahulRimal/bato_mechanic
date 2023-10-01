import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textEditingController = TextEditingController();
  File? _selectedImage;
  File? _selectedVideo;
  VideoPlayerController? _videoPlayerController;

  void _sendMessage(String message) {
    setState(() {
      _messages.add(ChatMessage(
        text: message,
        image: _selectedImage,
        video: _selectedVideo,
        isUserMessage: true,
      ));

      // Simulate the customer support response
      _messages.add(ChatMessage(
        text: 'Thank you for your message. How can I assist you?',
        isUserMessage: false,
      ));

      _selectedImage = null;
      _selectedVideo = null;
      _videoPlayerController?.dispose();
    });

    _textEditingController.clear();
  }

  Future<void> _selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _selectVideo(ImageSource source) async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: source);
    if (pickedVideo != null) {
      setState(() {
        _selectedVideo = File(pickedVideo.path);
        _videoPlayerController = VideoPlayerController.file(_selectedVideo!)
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController!.play();
          });
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: () {
                    _showImageSourceDialog();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.video_collection),
                  onPressed: () {
                    _showVideoSourceDialog();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_textEditingController.text.isNotEmpty) {
                      _sendMessage(_textEditingController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      alignment:
          message.isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: message.isUserMessage ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.text.isNotEmpty)
              Text(
                message.text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: message.isUserMessage ? Colors.white : Colors.black,
                ),
              ),
            if (message.image != null)
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                child: Image.file(
                  message.image!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            if (message.video != null)
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                child: AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController!),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _selectImage(ImageSource.camera);
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _selectImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showVideoSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Video Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _selectVideo(ImageSource.camera);
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _selectVideo(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChatMessage {
  final String text;
  final File? image;
  final File? video;
  final bool isUserMessage;

  ChatMessage({
    required this.text,
    this.image,
    this.video,
    required this.isUserMessage,
  });
}
