import 'package:firebase_login/keys.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  Future<void> delay([int seconds = 1]) async {
    await Future<void>.delayed(Duration(seconds: seconds));
  }

  group('Login firebase App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('check flutter driver health', () async {
      final health = await driver.checkHealth();
      expect(health.status, HealthStatus.ok);
    });

    test(
      'Check sing in when inputs NO registred credentials',
      () async {
        await driver.clearTimeline();
        // find widgets
        final emailInput = find.byValueKey(Keys.loginForm_emailInput_textField);
        final passwordInput =
            find.byValueKey(Keys.loginForm_passwordInput_textField);
        final continueButton =
            find.byValueKey(Keys.loginForm_continue_raisedButton);

        await driver.waitFor(emailInput);
        await driver.tap(emailInput); // acquire focus
        await driver.enterText('raul286162@hotmail.com'); // enter text
        await driver.waitFor(
            find.text('raul286162@hotmail.com')); // verify text appears on UI
        print('entered email');
        await delay();
        await driver.waitFor(passwordInput);
        await driver.tap(passwordInput); // acquire focus
        await driver.enterText('xbox1234'); // enter text
        await driver
            .waitFor(find.text('xbox1234')); // verify text appears on UI
        print('entered password');
        await delay();
        await driver.waitFor(continueButton);
        await driver.tap(continueButton);
      },
    );

    test(
      'Check sing in when inputs registred credentials',
      () async {
        await driver.clearTimeline();
        // find widgets
        final emailInput = find.byValueKey(Keys.loginForm_emailInput_textField);
        final passwordInput =
            find.byValueKey(Keys.loginForm_passwordInput_textField);
        final continueButton =
            find.byValueKey(Keys.loginForm_continue_raisedButton);

        await driver.waitFor(emailInput);
        await driver.tap(emailInput); // acquire focus
        await driver.enterText('raul.urtecho512@gmail.com'); // enter text
        await driver.waitFor(find
            .text('raul.urtecho512@gmail.com')); // verify text appears on UI
        print('entered email');
        await delay();
        await driver.waitFor(passwordInput);
        await driver.tap(passwordInput); // acquire focus
        await driver.enterText('xbox1234'); // enter text
        await driver
            .waitFor(find.text('xbox1234')); // verify text appears on UI
        print('entered password');
        await delay();
        await driver.waitFor(continueButton);
        await driver.tap(continueButton);
      },
    );
  });
}
