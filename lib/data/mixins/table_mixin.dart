import 'package:drift/drift.dart';

mixin TableMixin on Table {
  // Primary key
  late final id = integer().autoIncrement()();

  // Created at
  late final createdAt = dateTime().withDefault(currentDateAndTime)();
}
