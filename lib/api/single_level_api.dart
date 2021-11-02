import 'package:educamer/models/matiere.dart';

abstract class SingleLevelApi {
  Future<List<Matiere>> getAll();
}
