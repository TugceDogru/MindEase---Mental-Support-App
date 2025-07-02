import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/room_viewmodel.dart';

class CreateRoomView extends StatefulWidget {
  const CreateRoomView({super.key});

  @override
  State<CreateRoomView> createState() => _CreateRoomViewState();
}

class _CreateRoomViewState extends State<CreateRoomView> {
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Room', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF010221))),
        iconTheme: IconThemeData(color: Color(0xFF010221)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Room Name', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF010221))),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter room name',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              ),
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : () async {
                if (_nameController.text.trim().isEmpty) return;
                setState(() => _isLoading = true);
                final vm = Provider.of<RoomViewModel>(context, listen: false);
                vm.rooms.add(Room(id: DateTime.now().millisecondsSinceEpoch.toString(), name: _nameController.text.trim()));
                vm.notifyListeners();
                setState(() => _isLoading = false);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF010221),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
              ),
              child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Create Room'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
