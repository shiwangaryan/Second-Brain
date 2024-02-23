import 'package:isar/isar.dart';
part 'journal.g.dart';

@Collection()
class JournalEntry {
  Id id= Isar.autoIncrement;

  late String heading;
  late List<String> imageFiles;
  late String content;
  late List<String> audioFilePaths;
}