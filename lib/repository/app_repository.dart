import '../data/app_database.dart';

abstract class AppRepository {
  // Database instance (singleton)
  final database = AppDatabase();
}
