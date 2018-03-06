import 'dart:async';

import 'package:flutter_tools/src/build_info.dart';
import 'package:flutter_tools/src/application_package.dart';
import 'package:flutter_tools/src/device.dart';

class FakeLogReader extends DeviceLogReader {
  // TODO: implement logLines
  @override
  Stream<String> get logLines => const Stream<String>.empty();

  // TODO: implement name
  @override
  String get name => 'desktop';

}

class DesktopDevice extends Device {
  DesktopDevice(String id) : super(id);

  @override
  void clearLogs() {
    // TODO: implement clearLogs
  }

  @override
  DeviceLogReader getLogReader({ApplicationPackage app}) {
    return new FakeLogReader();
  }

  @override
  Future<bool> installApp(ApplicationPackage app) async {
    return true;
  }

  @override
  Future<bool> isAppInstalled(ApplicationPackage app) async {
    return true;
  }

  @override
  Future<bool> isLatestBuildInstalled(ApplicationPackage app) async {
    return true;
  }

  // TODO: implement isLocalEmulator
  @override
  Future<bool> get isLocalEmulator => null;

  @override
  bool isSupported() {
    return true;
  }

  // TODO: implement name
  @override
  String get name => 'desktop';

  // TODO: implement portForwarder
  @override
  DevicePortForwarder get portForwarder => null;

  // TODO: implement sdkNameAndVersion
  @override
  Future<String> get sdkNameAndVersion async => 'iOS 11.2 (simulator)';

  @override
  Future<LaunchResult> startApp(ApplicationPackage package, {String mainPath, String route, DebuggingOptions debuggingOptions, Map<String, dynamic> platformArgs, bool prebuiltApplication: false, bool applicationNeedsRebuild: false, bool usesTerminalUi: true, bool ipv6: false}) async {
    final Uri uri = Uri.parse('http://127.0.0.1:50300/');
    return new LaunchResult.succeeded(observatoryUri: uri);
  }

  @override
  Future<bool> stopApp(ApplicationPackage app) async {
    return true;
  }

  // TODO: implement targetPlatform
  @override
  Future<TargetPlatform> get targetPlatform async => TargetPlatform.ios;

  @override
  Future<bool> uninstallApp(ApplicationPackage app) async {
    return true;
  }

}

class DesktopDevices extends PollingDeviceDiscovery {
  DesktopDevices() : super('desktop');

  // TODO: implement canListAnything
  @override
  bool get canListAnything => true;

  final List<Device> _devices = <Device>[new DesktopDevice('desktop')];

  @override
  Future<List<Device>> pollingGetDevices() async {
    return _devices;
  }

  // TODO: implement supportsPlatform
  @override
  bool get supportsPlatform => true;

}