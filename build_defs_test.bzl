load("@bazel_skylib//lib:unittest.bzl", "asserts", "analysistest")
load(":build_defs.bzl", "fails_with_backtick_in_message")

def _failure_testing_test_impl(ctx):
    env = analysistest.begin(ctx)
    asserts.expect_failure(env, "Oh noes! Value `foo` should have been `bar`!")
    return analysistest.end(env)

failure_testing_test = analysistest.make(
    _failure_testing_test_impl,
    expect_failure = True,
)

def _my_rule_impl(ctx):
    fails_with_backtick_in_message()

_my_rule = rule(
    implementation = _my_rule_impl,
)

def test_failure():
    _my_rule(
        name = "this_should_fail",
        tags = ["manual"],
    )

    failure_testing_test(
      name = "failure_testing_test",
      target_under_test = ":this_should_fail",
    )
