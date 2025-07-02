import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/locator.dart';
import '../../viewmodels/expert_list_viewmodel.dart';
import '../../app/routes.dart';

class ExpertListView extends StatelessWidget {
  const ExpertListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExpertListViewModel>(
      create: (_) => locator<ExpertListViewModel>()..loadExperts(),
      child: Consumer<ExpertListViewModel>(
        builder: (context, vm, _) {
          if (vm.state == ExpertListState.busy) {
            return Center(child: CircularProgressIndicator());
          }
          if (vm.state == ExpertListState.error) {
            return Center(child: Text('Error: ${vm.error}'));
          }
          return ListView.builder(
            itemCount: vm.experts.length,
            itemBuilder: (context, i) {
              final ex = vm.experts[i];
              return ListTile(
                leading:
                    ex.photoUrl != null
                        ? CircleAvatar(
                          backgroundImage: NetworkImage(ex.photoUrl!),
                        )
                        : CircleAvatar(child: Icon(Icons.person)),
                title: Text(ex.fullName),
                subtitle: Text(ex.specialization),
                trailing: ElevatedButton(
                  child: Text('Book Appointment'),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.appointment,
                      arguments: ex.uid,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
