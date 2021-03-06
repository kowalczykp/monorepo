import 'package:metrics/project_groups/domain/value_objects/exceptions/project_group_name_validation_error_code.dart';
import 'package:metrics/project_groups/presentation/models/project_group_name_validation_error_message.dart';
import 'package:metrics/project_groups/presentation/strings/project_groups_strings.dart';
import 'package:test/test.dart';

void main() {
  group("ProjectGroupNameValidationErrorMessage", () {
    test(".message returns null if the given code is null", () {
      const errorMessage = ProjectGroupNameValidationErrorMessage(null);

      expect(errorMessage.message, isNull);
    });

    test(
      ".message returns project group name required error message if the given code is ProjectGroupNameValidationErrorCode.isNull",
      () {
        const errorMessage = ProjectGroupNameValidationErrorMessage(
          ProjectGroupNameValidationErrorCode.isNull,
        );

        expect(
          errorMessage.message,
          ProjectGroupsStrings.projectGroupNameRequired,
        );
      },
    );
  });
}
