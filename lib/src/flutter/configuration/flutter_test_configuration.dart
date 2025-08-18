import 'package:flutter_gherkin/flutter_gherkin_with_driver.dart';
import 'package:flutter_gherkin/src/flutter/parameters/existence_parameter.dart';
import 'package:flutter_gherkin/src/flutter/parameters/swipe_direction_parameter.dart';
import 'package:flutter_gherkin/src/flutter/steps/then_expect_widget_to_be_present_step.dart';
import 'package:flutter_gherkin/src/flutter/steps/when_long_press_widget_step.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';

class FlutterTestConfiguration extends TestConfiguration {
  /// ~~The path(s) to all the features.~~
  /// ~~All three [Pattern]s are supported: [RegExp], [String], [Glob].~~
  ///
  /// Instead of using this variable, give the features in the `@GherkinTestSuite(features: <String>[])` option.
  @deprecated
  Iterable<Pattern> features = const <Pattern>[];

  /// ~~The execution order of features - this default to random to avoid any inter-test dependencies~~
  ///
  /// Instead of using this variable, give the executionOrder in the `@GherkinTestSuite(executionOrder: ExecutionOrder.random)` option.
  @deprecated
  ExecutionOrder order = ExecutionOrder.random;

  /// ~~Lists feature files paths, which match [features] patterns.~~
  ///
  /// Instead of using this variable, give the features in the `@GherkinTestSuite(features: <String>[])` option.
  @deprecated
  FeatureFileMatcher featureFileMatcher = const IoFeatureFileAccessor();

  /// ~~The feature file reader.~~
  /// ~~Takes files/resources paths from [featureFileIndexer] and returns their content as String.~~
  ///
  /// Instead of using this variable, give the features in the `@GherkinTestSuite(features: <String>[])` option.
  @deprecated
  FeatureFileReader featureFileReader = const IoFeatureFileAccessor();

  /// Enable semantics in a test by creating a [SemanticsHandle].
  /// See:  [testWidgets] and [WidgetController.ensureSemantics].
  bool semanticsEnabled = true;

  /// Provide a configuration object with default settings such as the reports and feature file location
  /// Additional setting on the configuration object can be set on the returned instance.
  static FlutterTestConfiguration DEFAULT(
    Iterable<StepDefinitionGeneric<World>> steps, {
    String featurePath = 'integration_test/features/*.*.feature',
    String targetAppPath = 'test_driver/integration_test_driver.dart',
  }) {
    return FlutterTestConfiguration()
      ..features = [RegExp(featurePath)]
      ..reporters = [
        StdoutReporter(MessageLevel.error),
        ProgressReporter(),
        TestRunSummaryReporter(),
        // JsonReporter(path: './report.json'),
      ]
      ..stepDefinitions = steps;
  }

  @override
  void prepare() {
    customStepParameterDefinitions = List.from(
      customStepParameterDefinitions ?? Iterable.empty(),
    )..addAll([ExistenceParameter(), SwipeDirectionParameter()]);
    stepDefinitions = List.from(stepDefinitions ?? Iterable.empty())
      ..addAll([
        ThenExpectElementToHaveValue(),
        WhenTapBackButtonWidget(),
        WhenTapWidget(),
        WhenTapWidgetWithoutScroll(),
        WhenLongPressWidget(),
        WhenLongPressWidgetWithoutScroll(),
        WhenLongPressWidgetForDuration(),
        GivenOpenDrawer(),
        WhenPauseStep(),
        WhenFillFieldStep(),
        ThenExpectWidgetToBePresent(),
        RestartAppStep(),
        SiblingContainsTextStep(),
        SwipeOnKeyStep(),
        SwipeOnTextStep(),
        TapTextWithinWidgetStep(),
        TapWidgetOfTypeStep(),
        TapWidgetOfTypeWithinStep(),
        TapWidgetWithTextStep(),
        TextExistsStep(),
        TextExistsWithinStep(),
        WaitUntilKeyExistsStep(),
        WaitUntilTypeExistsStep(),
      ]);
  }
}
