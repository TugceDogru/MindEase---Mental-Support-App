import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/moderation_viewmodel.dart';

class ModerationHistoryView extends StatelessWidget {
  const ModerationHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ModerationViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Moderation History', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF010221))),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Color(0xFF010221)),
          ),
          body: ListView.builder(
            padding: EdgeInsets.all(24),
            itemCount: vm.history.length,
            itemBuilder: (context, i) {
              final result = vm.history[i];
              return Card(
                margin: EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(result.content, style: TextStyle(fontFamily: 'Poppins')),
                  subtitle: Text(
                    result.isAllowed
                        ? "Allowed"
                        : "Blocked: ${result.reason ?? ''}",
                    style: TextStyle(
                      color: result.isAllowed ? Colors.green : Colors.red,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  trailing: Text(
                    "${result.checkedAt.hour}:${result.checkedAt.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
} 