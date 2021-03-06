import 'package:ci_integration/client/jenkins/model/jenkins_build_result.dart';

/// A class providing methods for mapping Jenkins build result.
class JenkinsBuildResultMapper {
  /// A constant for the `ABORTED` result of Jenkins build.
  static const String aborted = 'ABORTED';

  /// A constant for the `NOT_BUILT` result of Jenkins build.
  static const String notBuilt = 'NOT_BUILT';

  /// A constant for the `FAILURE` result of Jenkins build.
  static const String failure = 'FAILURE';

  /// A constant for the `SUCCESS` result of Jenkins build.
  static const String success = 'SUCCESS';

  /// A constant for the `UNSTABLE` result of Jenkins build.
  static const String unstable = 'UNSTABLE';

  const JenkinsBuildResultMapper();

  /// Maps the [result] of Jenkins build to the [JenkinsBuildResult].
  JenkinsBuildResult map(String result) {
    switch (result) {
      case aborted:
        return JenkinsBuildResult.aborted;
      case notBuilt:
        return JenkinsBuildResult.notBuild;
      case failure:
        return JenkinsBuildResult.failure;
      case success:
        return JenkinsBuildResult.success;
      case unstable:
        return JenkinsBuildResult.unstable;
      default:
        return null;
    }
  }

  /// Maps the [result] of Jenkins build to the form of Jenkins API.
  String unmap(JenkinsBuildResult result) {
    switch (result) {
      case JenkinsBuildResult.aborted:
        return aborted;
      case JenkinsBuildResult.notBuild:
        return notBuilt;
      case JenkinsBuildResult.failure:
        return failure;
      case JenkinsBuildResult.success:
        return success;
      case JenkinsBuildResult.unstable:
        return unstable;
      default:
        return null;
    }
  }
}
