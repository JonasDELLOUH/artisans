import 'package:get_storage/get_storage.dart';
final box = GetStorage();
 deleteGetStorageKey({required String key}){
  return box.remove(key);
}

addInGetStorage({required String key, dynamic data}){
   return box.write(key, data);
}

dynamic getInGetStorage({required String key}){
   return box.read(key);
}

eraseGetStorage(){
   return box.erase();
}



