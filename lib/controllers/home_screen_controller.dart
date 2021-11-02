import 'package:educamer/models/niveau.dart';
import 'package:educamer/services/all_collection_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final AllLevelService _allLevelService = AllLevelService();
  RxList<Niveau> listLevel = <Niveau>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllLevels();
  }

  Future<void> getAllLevels() async {
    loading.value = true;
    try {
      listLevel.value = await _allLevelService.allLevels();
      loading.value = false;
    } on FirebaseException catch (e) {
      print(e.message);
    } finally {
      loading.value = false;
    }
  }
}
