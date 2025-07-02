import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/room_viewmodel.dart';
import 'create_room_view.dart';

class RoomListView extends StatelessWidget {
  const RoomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomViewModel>(
      create: (_) => RoomViewModel()..fetchRooms(),
      child: Consumer<RoomViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Rooms', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF010221))),
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(Icons.add, color: Color(0xFF010221)),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CreateRoomView()),
                    );
                  },
                ),
              ],
            ),
            body: vm.rooms.isEmpty
                ? Center(child: Text('No rooms yet', style: TextStyle(fontFamily: 'Poppins')))
                : ListView.separated(
                    padding: EdgeInsets.all(24),
                    itemCount: vm.rooms.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (context, i) {
                      final room = vm.rooms[i];
                      return ListTile(
                        title: Text(room.name, style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: Color(0xFF010221))),
                        trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF010221)),
                        onTap: () {
                          // TODO: Navigate to chat screen for this room
                        },
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
