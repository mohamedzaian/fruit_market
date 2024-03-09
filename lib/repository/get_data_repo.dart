import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_market/utils/firestore_key.dart';

class GetData
{
 Future<void> getOrganicFruits() async
 {
  await FirebaseFirestore.instance.collection(FireStoreKey().productCollection).where('category',isEqualTo: 'Organic Fruits').get();

   
 } 
}