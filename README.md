# Bazel Test Shell Eval

This tests a simple Bazel macro which fails with a message containing backticks.
The test fails by attempting to execute the text within the backticks.

## Steps to reproduce:

```shell
bazel test //:all
```

Outputs error message:

```
Loading: 
Loading: 0 packages loaded
Analyzing: target //:failure_testing_test (0 packages loaded, 0 targets configured)
DEBUG: /home/douglasparker/.cache/bazel/_bazel_douglasparker/f8daf9e1b24fe39f31e93c50d2583d6b/external/bazel_skylib/lib/unittest.bzl:351:10: In test _failure_testing_test_impl from //:build_defs_test.bzl: Expected errors to contain 'Oh noes! Value `foo` should have been `bar`!' but did not. Actual errors:
Traceback (most recent call last):
	File "/home/douglasparker/Source/bazel-test-eval/BUILD", line 3
		_my_rule(name = 'this_should_fail')
	File "/home/douglasparker/Source/bazel-test-eval/build_defs_test.bzl", line 15, in _my_rule_impl
		fails_with_backtick_in_message()
	File "/home/douglasparker/Source/bazel-test-eval/build_defs.bzl", line 2, in fails_with_backtick_in_message
		fail(<1 more arguments>)
Oh noes! Value `bar` should have been `foo`!
INFO: Analyzed target //:failure_testing_test (0 packages loaded, 0 targets configured).
INFO: Found 1 test target...
[0 / 2] [Prepa] BazelWorkspaceStatusAction stable-status.txt
[1 / 2] Testing //:failure_testing_test; 1s linux-sandbox
FAIL: //:failure_testing_test (see /home/douglasparker/.cache/bazel/_bazel_douglasparker/f8daf9e1b24fe39f31e93c50d2583d6b/execroot/__main__/bazel-out/k8-fastbuild/testlogs/failure_testing_test/test.log)
INFO: From Testing //:failure_testing_test:
==================== Test output for //:failure_testing_test:
/home/douglasparker/.cache/bazel/_bazel_douglasparker/f8daf9e1b24fe39f31e93c50d2583d6b/sandbox/linux-sandbox/9/execroot/__main__/bazel-out/k8-fastbuild/bin/failure_testing_test.sh.runfiles/__main__/failure_testing_test.sh: line 1: foo: command not found
/home/douglasparker/.cache/bazel/_bazel_douglasparker/f8daf9e1b24fe39f31e93c50d2583d6b/sandbox/linux-sandbox/9/execroot/__main__/bazel-out/k8-fastbuild/bin/failure_testing_test.sh.runfiles/__main__/failure_testing_test.sh: line 1: bar: command not found
/home/douglasparker/.cache/bazel/_bazel_douglasparker/f8daf9e1b24fe39f31e93c50d2583d6b/sandbox/linux-sandbox/9/execroot/__main__/bazel-out/k8-fastbuild/bin/failure_testing_test.sh.runfiles/__main__/failure_testing_test.sh: line 1: bar: command not found
/home/douglasparker/.cache/bazel/_bazel_douglasparker/f8daf9e1b24fe39f31e93c50d2583d6b/sandbox/linux-sandbox/9/execroot/__main__/bazel-out/k8-fastbuild/bin/failure_testing_test.sh.runfiles/__main__/failure_testing_test.sh: line 1: foo: command not found
In test _failure_testing_test_impl from //:build_defs_test.bzl: Expected errors to contain 'Oh noes! Value  should have been !' but did not. Actual errors:
Traceback (most recent call last):
	File "/home/douglasparker/Source/bazel-test-eval/BUILD", line 3
		_my_rule(name = 'this_should_fail')
	File "/home/douglasparker/Source/bazel-test-eval/build_defs_test.bzl", line 15, in _my_rule_impl
		fails_with_backtick_in_message()
	File "/home/douglasparker/Source/bazel-test-eval/build_defs.bzl", line 2, in fails_with_backtick_in_message
		fail(<1 more arguments>)
Oh noes! Value  should have been !

================================================================================
Target //:failure_testing_test up-to-date:
  bazel-bin/failure_testing_test.sh
INFO: Elapsed time: 1.977s, Critical Path: 1.82s
INFO: 2 processes: 2 linux-sandbox.
INFO: Build completed, 1 test FAILED, 2 total actions
//:failure_testing_test                                                  FAILED in 1.7s
  /home/douglasparker/.cache/bazel/_bazel_douglasparker/f8daf9e1b24fe39f31e93c50d2583d6b/execroot/__main__/bazel-out/k8-fastbuild/testlogs/failure_testing_test/test.log

Executed 1 out of 1 test: 1 fails locally.
INFO: Build completed, 1 test FAILED, 2 total actions
```

Notable lines include:

```
foo: command not found
```

```
bar: command not found
```

```
Oh noes! Value  should have been !
```
