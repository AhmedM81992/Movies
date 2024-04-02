import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/models/favlist_model.dart';

class FireBaseFunctions {
  static CollectionReference<FavListModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("FavList")
        .withConverter<FavListModel>(fromFirestore: (snapshot, options) {
      return FavListModel.fromJson(snapshot.data() ?? {});
    }, toFirestore: (favlist, _) {
      return favlist.toJson();
    });
  }

  static Future<void> addFav(FavListModel model) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    model.id = docRef.id;
    return docRef.set(model);
  }
}
