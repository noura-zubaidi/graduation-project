import 'package:books_application/presentation/screens/login_screen.dart';
import 'package:books_application/services/authentication.dart';

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _userData;
  String _imageUrl = '';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await _authService.getCurrentUserData();
    setState(() {
      _userData = userData;
      _nameController.text = _userData!['name'] ?? '';
      _emailController.text = _userData!['email'] ?? '';
      _bioController.text = _userData!['bio'] ?? '';
      _imageController.text = _userData!['image'] ?? '';
      _imageUrl = _userData!['image'] ?? '';
    });
  }

  Future<void> _editUserData() async {
    final result = await showDialog(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: AlertDialog(
          title: Text('Edit User Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _bioController,
                decoration: InputDecoration(labelText: 'Bio'),
              ),
              TextField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final name = _nameController.text;

                final bio = _bioController.text;
                final image = _imageController.text;
                final result = await _authService.editUserData(
                  name: name,
                  bio: bio,
                  image: image,
                );
                if (result == 'Success') {
                  setState(() {
                    _imageUrl = image;
                  });
                  Navigator.pop(context, 'Success');
                } else {
                  // Show an error message
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );

    if (result == 'Success') {
      _loadUserData();
    }
  }

  Future<void> _logout() async {
    await _authService.logout();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile',
            style: Theme.of(context).textTheme.headlineSmall),
        centerTitle: true,
      ),
      body: _userData == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: _imageUrl.isNotEmpty
                              ? NetworkImage(_imageUrl)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Name: ${_userData!['name']}',
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(
                        height: 7,
                      ),
                      Text('Email: ${_userData!['email']}',
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(
                        height: 7,
                      ),
                      Text('Bio: ${_userData!['bio'] ?? 'No bio available'}',
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: Size(200, 50),
                        ),
                        onPressed: _editUserData,
                        child: Text(
                          'Edit Info',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: Size(200, 50),
                        ),
                        onPressed: _logout,
                        child: Text(
                          'Log Out',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
