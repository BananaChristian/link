import 'package:flutter/material.dart';
import 'package:link/components/user_list.dart';
import 'package:link/pages/other_pages/chat_page.dart';
import 'package:link/services/auth/auth_service.dart';
import 'package:link/services/chat/chat_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  String? _currentUserId;

  Future<void> _fetchCurrentUser() async{
    final currentUser = await _authService.getCurrentUser();
    setState(() {
      _currentUserId = currentUser?.uid;
    });
  }

  @override
  void initState(){
    super.initState();
    _fetchCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        child:Icon(Icons.person)
                      ),
                      Text('LINK',style:TextStyle(color:Theme.of(context).colorScheme.secondary,fontSize: 25)),
                      const Icon(Icons.search)
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Chats'),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: _buildUserList(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Sorry an error occured ${snapshot.error}'));
          } else if (!snapshot.hasData||snapshot.data!.isEmpty) {
            return const Center(child: Text('Sorry no users were found'));
          }
          final users = snapshot.data;
          final filteredUsers=users?.where((user)=>user['uid']!= _currentUserId).toList();

          return ListView.builder(
              itemCount: filteredUsers?.length,
              itemBuilder: (context, index) {
                final user = filteredUsers?[index];
                final username=user?['username'];
                final email=user?['email'];
                final uid=user?['uid'];
                if(username==null||email==null||uid==null){
                  return const SizedBox();
                }
                return Column(
                  children: [
                    UserList(
                      username: user?['username'] ?? 'Unkown username',
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      username: username,
                                      email: email, 
                                      receiverID: uid, 
                                    )));
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              });
        });
  }
}
