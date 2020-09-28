class ApiUrl {
  static const String getAllUsersUrl =
      'https://farmapi.conveyor.cloud/api/User/GetAllUsers';

  static const String getUserUrl =
      'https://farmapi.conveyor.cloud/api/User/GetUserByUsernameAndPassword?';

  static const String getAllWorkersUrl =
      'https://farmapi.conveyor.cloud/api/Worker/GetAllWorkers';

  static const String getQuantitiesByWorkerUrl =
      'https://farmapi.conveyor.cloud/api/Worker/GetQuantitiesByWorker?workername=';

  static const String getQuantitiesByPlantationUrl =
      'https://farmapi.conveyor.cloud/api/Plantation/GetQuantitiesByPlantation?username=';

  static const String getAllPlantationsUrl =
      'https://farmapi.conveyor.cloud/api/Plantation/GetAllPlantation';

  static const String addUserUrl =
      'https://farmapi.conveyor.cloud/api/User/AddUser';

  static const String addHarvestQunatityUrl =
      'https://farmapi.conveyor.cloud/api/Worker/AddHarvestedQuantityByWorker';

  static const String addWorkerUrl =
      'https://farmapi.conveyor.cloud/api/Worker/AddWorker';
}
