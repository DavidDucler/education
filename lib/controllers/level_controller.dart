import 'package:educamer/models/matiere.dart';
import 'package:educamer/services/single_level_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class LevelController extends GetxController {
  final SingleLevelService singleLevelService = SingleLevelService();
  RxList<Matiere> listMatiere = <Matiere>[].obs;
  RxBool loading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getLevelMatieres({String collectionName}) async {
    loading.value = true;
    try {
      listMatiere.value =
          await singleLevelService.getAll(collectionName: collectionName);
      loading.value = false;
    } on FirebaseException catch (e) {
      print(e.message);
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }
}
