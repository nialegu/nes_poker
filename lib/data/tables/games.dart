import 'package:drift/drift.dart';
import 'package:nes_poker_cash_tools/data/mixins/table_mixin.dart';

@DataClassName('Game')
class Games extends Table with TableMixin {
  // Name
  late final name = text()();
}
