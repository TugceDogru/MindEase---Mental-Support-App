import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/locator.dart';
import '../../viewmodels/appointment_viewmodel.dart';
import '../../services/auth_service.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final expertId = ModalRoute.of(context)!.settings.arguments as String;
    final userId = locator<AuthService>().currentUser!.uid;

    return ChangeNotifierProvider<AppointmentViewModel>(
      create: (_) => locator<AppointmentViewModel>(),
      child: Consumer<AppointmentViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            appBar: AppBar(title: Text('Randevu Ayarla')),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Uzman: $expertId'),
                  SizedBox(height: 16),
                  Text('Tarih & Saat: ${vm.formattedDate}'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => vm.pickDateTime(context),
                    child: Text('Tarih/Saat Seç'),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: vm.isOnline,
                        onChanged: (v) => vm.isOnline = v ?? true,
                      ),
                      Text('Online Seans'),
                    ],
                  ),
                  SizedBox(height: 24),
                  vm.state == AppointmentState.booking
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                        onPressed: () async {
                          final ok = await vm.book(
                            expertId: expertId,
                            userId: userId,
                          );
                          final msg =
                              ok ? 'Randevu oluşturuldu.' : 'Hata: ${vm.error}';
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(msg)));
                          if (ok) Navigator.pop(context);
                        },
                        child: Text('Onayla'),
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
