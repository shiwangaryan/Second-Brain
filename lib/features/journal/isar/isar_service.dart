import 'package:isar/isar.dart';
import 'package:solution_challenge_app/features/journal/isar/entities/journal.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    // db = Isar.open(JournalEntrySchema, directory: directory);
  }
}
