import 'package:ci_integration/cli/command/ci_integration_command.dart';
import 'package:ci_integration/cli/logger/logger.dart';
import 'package:ci_integration/cli/runner/ci_integration_runner.dart';
import 'package:test/test.dart';

import '../test_util/stub/logger_stub.dart';

void main() {
  group("CiIntegrationCommand", () {
    const optionName = 'test-option';

    final logger = LoggerStub();
    final command = CiIntegrationCommandStub(logger);
    final runner = CiIntegrationsRunner(logger);

    setUpAll(() {
      runner.addCommand(command);
      command.argParser.addOption(optionName);
    });

    test(
      "should throw ArgumentError trying to create instance with null logger",
      () {
        expect(() => CiIntegrationCommandStub(null), throwsArgumentError);
      },
    );

    test(
      ".getArgumentValue() should return null if option was not parsed",
      () async {
        await runner.run(['test']);
        final optionValue = command.getArgumentValue(optionName);

        expect(optionValue, isNull);
      },
    );

    test(
      ".getArgumentValue() should return the argument value",
      () async {
        const argumentValue = 'argumentValue';
        await runner.run(['test', '--$optionName', argumentValue]);
        final parsed = command.getArgumentValue(optionName);

        expect(parsed, equals(argumentValue));
      },
    );
  });
}

/// A stub class for a [CiIntegrationCommand] abstract class providing
/// a test implementation.
class CiIntegrationCommandStub extends CiIntegrationCommand {
  @override
  String get description => 'test description';

  @override
  String get name => 'test';

  CiIntegrationCommandStub(Logger logger) : super(logger);

  @override
  void run() {}
}
