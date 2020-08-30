import 'package:permission_handler/permission_handler.dart';

Map<Permission, PermissionStatus> dataToStatusesMap(Map<String, bool> data){

  Map<Permission, PermissionStatus> statusesMap = new Map<Permission, PermissionStatus>();
  if (data.containsKey('camera')){
    if (data['camera'] == true){
      statusesMap[Permission.camera] = PermissionStatus.granted;
    } else {
      statusesMap[Permission.camera] = PermissionStatus.denied;
    }
  }
  return statusesMap;

}

Map<String, bool> statusesToDataMap(Map<Permission, PermissionStatus> statuses){

  return {
    'camera' : statuses.containsKey(Permission.camera) ?
        PermissionStatusToBoolean(statuses[Permission.camera]): false,
  };

}

bool PermissionStatusToBoolean(PermissionStatus status){
  if (status != PermissionStatus.granted){
    return false;
  } else {
    return true;
  }
}

Map<Permission, PermissionStatus> getDefaultStatusesMap(){

  Map<Permission, PermissionStatus> statusesMap = new Map<Permission, PermissionStatus>();
  statusesMap[Permission.camera] = PermissionStatus.denied;
  return statusesMap;

}