import 'package:flutter/material.dart';
import 'package:link/components/custom_fields.dart';
import 'package:link/components/message_bubble.dart';
import 'package:link/services/auth/auth_service.dart';
import 'package:link/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String username; //ReceiverName
  final String receiverID;
  final String email;
  const ChatPage(
      {super.key,
      required this.username,
      required this.email,
      required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  String? senderID;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSenderID();
  }

  void _fetchSenderID() async {
    final user = await _authService.getCurrentUser();
    setState(() {
      senderID = user?.uid;
      isLoading = false;
    });
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverID, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const CircleAvatar(
                child:Icon(Icons.person)
              ),
              const SizedBox(width: 10),
              Text(widget.username),
            ],
          ),
        ),
        elevation: 0.8,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              //The messages
              Expanded(child:_buildMessagesSection()),
              //User input
              Row(
                children: [
                  Container(
                    width:MediaQuery.of(context).size.width*0.8,
                    padding:const EdgeInsets.all(10),
                    child: CustomFields(
                        controller: messageController,
                        hintText: 'Enter a message',
                        color: Theme.of(context).colorScheme.primary,
                        obscureText: false),
                  ),
                  IconButton(
                    icon: Icon(Icons.send,color:Theme.of(context).colorScheme.primary),
                    onPressed: sendMessage,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessagesSection() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (senderID == null) {
      return const Center(child: Text('Unable to fetch sender ID'));
    }

    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('An error ${snapshot.error} occurred'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No messages found'));
        }

        final messages = snapshot.data;
        return ListView.builder(
          reverse: false,
          itemCount: messages!.docs.length,
          itemBuilder: (context, index) {
            final message = messages.docs[index];
            final messageSenderID=message['senderID'];
            final isSender=messageSenderID==senderID;
            return MessageBubble(
              alignment: isSender? Alignment.centerRight:Alignment.centerLeft,
              message: message['message'] ?? '',
              bubbleColor: isSender?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.secondary,
            );
          },
        );
      },
    );
  }
}