import 'constant.dart';

List<Device> filterData = deviceData;
void germanyData() {
  filterData = deviceData
      .where(
          (device) => device.deviceId == "D0315" || device.deviceId == "D0318")
      .toList();
}

void SpainData() {
  filterData = deviceData
      .where((device) =>
          device.deviceId == "D1003" ||
          device.deviceId == "D1004" ||
          device.deviceId == "D1005")
      .toList();
}

void FranceData() {
  filterData = deviceData
      .where((device) =>
          device.deviceId == "D0500" ||
          device.deviceId == "D0501" ||
          device.deviceId == "D0502" ||
          device.deviceId == "D0503" ||
          device.deviceId == "D0504" ||
          device.deviceId == "D0505")
      .toList();
}

void UKData() {
  filterData = deviceData
      .where(
          (device) => device.deviceId == "D0507" || device.deviceId == "D0508")
      .toList();
}

void LabData() {
  filterData =
      deviceData.where((device) => device.deviceId == "D0506").toList();
}

void allData() {
  filterData = deviceData;
}
