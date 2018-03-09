import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter_tools/src/base/file_system.dart';
import 'package:flutter_tools/src/base/io.dart';
import 'package:flutter_tools/src/build_info.dart';
import 'package:flutter_tools/src/application_package.dart';
import 'package:flutter_tools/src/device.dart';
import 'package:flutter_tools/src/globals.dart';

final String _customDeviceName = 'custom';

class CustomDevicePackage extends ApplicationPackage {
  final String scriptPath;

  CustomDevicePackage(this.scriptPath);

  static CustomDevicePackage fromCurrentDirectory() {
    final String scriptPath = fs.path.join('desktop', 'launch.dart');
    final io.File file = new io.File(scriptPath);

    if (file.existsSync()) {
      return new CustomDevicePackage(file.path);
    } else {
      return null;
    }
  }

  // TODO: implement name
  @override
  String get name => _customDeviceName;
}

class CustomDevice extends Device {
  CustomDevice(String id) : super(id);

  Process _runningApp;

  @override
  void clearLogs() {}

  @override
  DeviceLogReader getLogReader({ApplicationPackage app}) {
    return new CustomDeviceLogReader(_streamController.stream);
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

  @override
  Future<bool> get isLocalEmulator async => false;

  @override
  bool isSupported() {
    return true;
  }

  @override
  String get name => _customDeviceName;

  @override
  DevicePortForwarder get portForwarder => null;

  @override
  Future<String> get sdkNameAndVersion async => io.Platform.operatingSystem;

  final StreamController<String> _streamController = new StreamController<String>.broadcast();

  @override
  Future<LaunchResult> startApp(ApplicationPackage package,
      {String mainPath,
      String route,
      DebuggingOptions debuggingOptions,
      Map<String, dynamic> platformArgs,
      bool prebuiltApplication: false,
      bool applicationNeedsRebuild: false,
      bool usesTerminalUi: true,
      bool ipv6: false}) async {

    final CustomDevicePackage customPackage = package;

    printStatus('Executing ${customPackage.scriptPath}');
    final String dartPath = io.Platform.resolvedExecutable;

    try {
      _runningApp = await Process.start(dartPath, <String>[customPackage.scriptPath]);
      _streamController.addStream(_runningApp.stdout.transform(UTF8.decoder));

      final String searchingFor = 'Observatory listening on ';
      final String line = await _streamController.stream.firstWhere((String x) => x.startsWith(searchingFor));
      final Uri uri = Uri.parse(line.replaceFirst(searchingFor, '').replaceFirst('\n', ''));

      if (uri.port == 0) {
        printStatus('Invalid uri ${_runningApp.stdout} ${_runningApp.stderr}');
        return new LaunchResult.failed();
      } else {
        printStatus('Received Uri $uri');
        return new LaunchResult.succeeded(observatoryUri: uri);
      }
    } catch (exception) {
      printStatus('Failed to execute $exception');
      return new LaunchResult.failed();
    }
  }

  @override
  Future<bool> stopApp(ApplicationPackage app) async {
    _runningApp?.kill();
    return true;
  }

  @override
  Future<TargetPlatform> get targetPlatform async => TargetPlatform.custom;

  @override
  Future<bool> uninstallApp(ApplicationPackage app) async {
    return true;
  }
}

class CustomDeviceDiscovery extends PollingDeviceDiscovery {
  CustomDeviceDiscovery() : super(_customDeviceName);

  @override
  bool get canListAnything => true;

  @override
  bool get supportsPlatform => true;

  final List<Device> _devices = <Device>[new CustomDevice(_customDeviceName)];

  @override
  Future<List<Device>> pollingGetDevices() async {
    return _devices;
  }
}

class CustomDeviceLogReader extends DeviceLogReader {
  @override
  final Stream<String> logLines;

  CustomDeviceLogReader(this.logLines);

  @override
  String get name => _customDeviceName;
}
