import 'package:educamer/models/niveau.dart';

abstract class AllLevelApi {
  Future<List<Niveau>> allLevels();
}
