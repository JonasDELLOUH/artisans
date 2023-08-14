import 'package:artisans/core/services/my_get_storage.dart';
import 'package:get_storage/get_storage.dart';
 deleteGetStorageKey({required String key}){
  return MyGetStorage.instance.remove(key);
}

addInGetStorage({required String key, dynamic data}){
   return MyGetStorage.instance.write(key, data);
}

dynamic getInGetStorage({required String key}){
   return MyGetStorage.instance.read(key);
}

eraseGetStorage(){
   return MyGetStorage.instance.erase();
}



