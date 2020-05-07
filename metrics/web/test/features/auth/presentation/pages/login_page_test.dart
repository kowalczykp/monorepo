import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metrics/features/auth/presentation/model/auth_error_message.dart';
import 'package:metrics/features/auth/presentation/state/auth_store.dart';
import 'package:metrics/features/auth/presentation/strings/auth_strings.dart';
import 'package:metrics/features/auth/presentation/widgets/auth_form.dart';
import 'package:metrics/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:metrics/features/common/presentation/routes/route_generator.dart';
import 'package:metrics/features/common/presentation/strings/common_strings.dart';
import 'package:metrics/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:metrics/features/dashboard/presentation/state/project_metrics_store.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../test_utils/project_metrics_store_mock.dart';
import '../../../../test_utils/project_metrics_store_stub.dart';
import '../../../../test_utils/signed_in_auth_store_fake.dart';

void main() {
  group("LoginPage", () {
    testWidgets(
      "contains project's title",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _LoginPageTestbed());

        expect(find.text(CommonStrings.metrics), findsOneWidget);
      },
    );

    testWidgets(
      "contains authentication form",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _LoginPageTestbed());

        expect(find.byType(AuthForm), findsOneWidget);
      },
    );

    testWidgets(
      "navigates to the dashboard page if the login was successful",
      (WidgetTester tester) async {
        await tester.pumpWidget(const _LoginPageTestbed());

        await _signIn(tester);
        await tester.pumpAndSettle();

        expect(find.byType(DashboardPage), findsOneWidget);
      },
    );

    testWidgets(
      "subscribes to projects if login was successful",
      (tester) async {
        final metricsStore = ProjectMetricsStoreMock();

        await tester.pumpWidget(_LoginPageTestbed(metricsStore: metricsStore));

        await _signIn(tester);

        verify(metricsStore.subscribeToProjects()).called(equals(1));
      },
    );

    testWidgets(
      "redirects to the dashboard page if a user is already signed in",
      (WidgetTester tester) async {
        await tester.pumpWidget(_LoginPageTestbed(
          authStore: SignedInAuthStoreFake(),
        ));
        await tester.pump();

        expect(find.byType(DashboardPage), findsOneWidget);
      },
    );
  });
}

Future<void> _signIn(WidgetTester tester) async {
  await tester.enterText(
    find.widgetWithText(AuthInputField, AuthStrings.email),
    'test@email.com',
  );
  await tester.enterText(
    find.widgetWithText(AuthInputField, AuthStrings.password),
    'testPassword',
  );
  await tester.tap(find.widgetWithText(RaisedButton, AuthStrings.signIn));
}

class _LoginPageTestbed extends StatelessWidget {
  final AuthStore authStore;
  final ProjectMetricsStore metricsStore;

  const _LoginPageTestbed({
    this.authStore,
    this.metricsStore = const ProjectMetricsStoreStub(),
  });

  @override
  Widget build(BuildContext context) {
    return Injector(
      inject: [
        Inject<AuthStore>(() => authStore ?? AuthStoreStub()),
        Inject<ProjectMetricsStore>(() => metricsStore),
      ],
      initState: () {
        Injector.getAsReactive<AuthStore>().setState(
          (store) => store.subscribeToAuthenticationUpdates(),
        );
      },
      builder: (BuildContext context) {
        return MaterialApp(
          title: 'Login Page',
          onGenerateRoute: (settings) => RouteGenerator.generateRoute(
            settings: settings,
            isLoggedIn: Injector.get<AuthStore>().isLoggedIn,
          ),
        );
      },
    );
  }
}

class AuthStoreStub implements AuthStore {
  final BehaviorSubject<bool> _isLoggedInSubject = BehaviorSubject();

  @override
  bool get isLoggedIn => _isLoggedInSubject.value;

  @override
  Stream<bool> get loggedInStream => _isLoggedInSubject.stream;

  @override
  AuthErrorMessage get authErrorMessage => null;

  @override
  void subscribeToAuthenticationUpdates() {
    _isLoggedInSubject.add(false);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _isLoggedInSubject.add(true);
  }

  @override
  Future<void> signOut() async {
    _isLoggedInSubject.add(false);
  }

  @override
  void dispose() {}
}