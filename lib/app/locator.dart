import 'package:get_it/get_it.dart';

// Services
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/storage_service.dart';
import '../services/moderation_service.dart';
import '../services/notification_service.dart';

// ViewModels
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/profile_viewmodel.dart';
import '../viewmodels/feed_viewmodel.dart';
import '../viewmodels/room_viewmodel.dart';
import '../viewmodels/moderation_viewmodel.dart';
import '../viewmodels/mood_viewmodel.dart';
import '../viewmodels/expert_list_viewmodel.dart';
import '../viewmodels/appointment_viewmodel.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // --- Service registrations ---
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<FirestoreService>(() => FirestoreService());
  locator.registerLazySingleton<StorageService>(() => StorageService());
  locator.registerLazySingleton<ModerationService>(() => ModerationService());
  locator.registerLazySingleton<NotificationService>(
    () => NotificationService(),
  );

  // --- ViewModel registrations ---
  locator.registerFactory<AuthViewModel>(() => AuthViewModel());
  locator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
  locator.registerFactory<FeedViewModel>(() => FeedViewModel());
  locator.registerFactory<RoomViewModel>(() => RoomViewModel());
  locator.registerFactory<ModerationViewModel>(() => ModerationViewModel());
  locator.registerFactory<MoodViewModel>(() => MoodViewModel());
  locator.registerFactory<ExpertListViewModel>(() => ExpertListViewModel());
  locator.registerFactory<AppointmentViewModel>(() => AppointmentViewModel());
}
