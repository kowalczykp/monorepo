import '../../../common/config/device.dart';
import '../../common/command/command_builder.dart';

/// Base class for wrappers of the flutter command.
///
/// Contains all common command params for flutter executable.
abstract class FlutterCommand extends CommandBuilder {
  static const executableName = 'flutter';

  /// --verbose
  ///
  /// Noisy logging, including all shell commands executed.
  void verbose() => add('--verbose');

  ///  --device-id
  ///
  ///  Target device id or name (prefixes allowed).
  void device(Device device) => add('--device-id=${device.deviceId}');

  /// --machine
  ///
  /// Outputs the information using JSON.
  void machine() => add('--machine');
}
