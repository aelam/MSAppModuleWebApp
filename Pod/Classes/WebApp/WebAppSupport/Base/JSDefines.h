/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#if __OBJC__
#  import <Foundation/Foundation.h>
#endif

/**
 * Make global functions usable in C++
 */
#if defined(__cplusplus)
#define JS_EXTERN extern "C" __attribute__((visibility("default")))
#else
#define JS_EXTERN extern __attribute__((visibility("default")))
#endif

/**
 * The JS_DEBUG macro can be used to exclude error checking and logging code
 * from release builds to improve performance and reduce binary size.
 */
#ifndef JS_DEBUG
#if DEBUG
#define JS_DEBUG 1
#else
#define JS_DEBUG 0
#endif
#endif

/**
 * The JS_DEV macro can be used to enable or disable development tools
 * such as the debug executors, dev menu, red box, etc.
 */
#ifndef JS_DEV
#if DEBUG
#define JS_DEV 1
#else
#define JS_DEV 0
#endif
#endif

#if JS_DEV
#define JS_IF_DEV(...) __VA_ARGS__
#else
#define JS_IF_DEV(...)
#endif

/**
 * By default, only raise an NSAssertion in debug mode
 * (custom assert functions will still be called).
 */
#ifndef JS_NSASSERT
#if JS_DEBUG
#define JS_NSASSERT 1
#else
#define JS_NSASSERT 0
#endif
#endif

/**
 * Concat two literals. Supports macro expansions,
 * e.g. JS_CONCAT(foo, __FILE__).
 */
#define JS_CONCAT2(A, B) A ## B
#define JS_CONCAT(A, B) JS_CONCAT2(A, B)

/**
 * Throw an assertion for unimplemented methods.
 */
#define JS_NOT_IMPLEMENTED(method) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wmissing-method-return-type\"") \
_Pragma("clang diagnostic ignored \"-Wunused-parameter\"") \
JS_EXTERN NSException *_JSNotImplementedException(SEL, Class); \
method NS_UNAVAILABLE { @throw _JSNotImplementedException(_cmd, [self class]); } \
_Pragma("clang diagnostic pop")
