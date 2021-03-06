import 'package:ci_integration/destination/firestore/config/model/firestore_destination_config.dart';
import 'package:test/test.dart';

import '../../test_utils/test_data/firestore_config_test_data.dart';

void main() {
  group("FirestoreDestinationConfig", () {
    const firestoreConfigJson =
        FirestoreConfigTestData.firestoreDestinationConfigMap;
    final firestoreConfig = FirestoreConfigTestData.firestoreDestiantionConfig;

    test(
      "can't be created when the metricsProjectId is null",
      () {
        expect(
          () => FirestoreDestinationConfig(
            metricsProjectId: null,
            firebaseProjectId: FirestoreConfigTestData.firebaseProjectId,
            firebaseUserEmail: FirestoreConfigTestData.firebaseUserEmail,
            firebaseUserPassword: FirestoreConfigTestData.firebaseUserPassword,
            firebaseWebApiKey: FirestoreConfigTestData.firebaseWebApiKey,
          ),
          throwsArgumentError,
        );
      },
    );

    test(
      "can't be created when the firebaseProjectId is null",
      () {
        expect(
          () => FirestoreDestinationConfig(
            metricsProjectId: FirestoreConfigTestData.metricsProjectId,
            firebaseProjectId: null,
            firebaseUserEmail: FirestoreConfigTestData.firebaseUserEmail,
            firebaseUserPassword: FirestoreConfigTestData.firebaseUserPassword,
            firebaseWebApiKey: FirestoreConfigTestData.firebaseWebApiKey,
          ),
          throwsArgumentError,
        );
      },
    );

    test(
      "can't be created when the firebaseUserEmail is null",
      () {
        expect(
          () => FirestoreDestinationConfig(
            metricsProjectId: FirestoreConfigTestData.metricsProjectId,
            firebaseProjectId: FirestoreConfigTestData.firebaseProjectId,
            firebaseUserEmail: null,
            firebaseUserPassword: FirestoreConfigTestData.firebaseUserPassword,
            firebaseWebApiKey: FirestoreConfigTestData.firebaseWebApiKey,
          ),
          throwsArgumentError,
        );
      },
    );

    test(
      "can't be created when the firebaseUserPassword is null",
      () {
        expect(
          () => FirestoreDestinationConfig(
            metricsProjectId: FirestoreConfigTestData.metricsProjectId,
            firebaseProjectId: FirestoreConfigTestData.firebaseProjectId,
            firebaseUserEmail: FirestoreConfigTestData.firebaseUserEmail,
            firebaseUserPassword: null,
            firebaseWebApiKey: FirestoreConfigTestData.firebaseWebApiKey,
          ),
          throwsArgumentError,
        );
      },
    );

    test(
      "can't be created when the firebaseWebApiKey is null",
      () {
        expect(
          () => FirestoreDestinationConfig(
            metricsProjectId: FirestoreConfigTestData.metricsProjectId,
            firebaseProjectId: FirestoreConfigTestData.firebaseProjectId,
            firebaseUserEmail: FirestoreConfigTestData.firebaseUserEmail,
            firebaseUserPassword: FirestoreConfigTestData.firebaseUserPassword,
            firebaseWebApiKey: null,
          ),
          throwsArgumentError,
        );
      },
    );

    test(
      ".fromJson() returns null if the given JSON map is null",
      () {
        final config = FirestoreDestinationConfig.fromJson(null);

        expect(config, isNull);
      },
    );

    test(
      '.fromJson() creates an instance of FirestoreConfig from JSON encodable Map',
      () {
        final parsed = FirestoreDestinationConfig.fromJson(firestoreConfigJson);

        expect(parsed, equals(firestoreConfig));
      },
    );
  });
}
