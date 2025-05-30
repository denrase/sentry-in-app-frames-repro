# Sentry In App Frames Repro

## Setup

- The app includes static sentry through SPM. Version 8.50.2
- Added a new sentry project & wizzard was run to get symbolicated stack traces.
- There are two SPM libraries, StaticLib & DynamicLib. The latter is defined to be a dynamic library.
- Both are included locally though SPM.
- We always start the app with one of the error enum cases:
```swift 
enum InAppFramesError: Error {
    case staticError
    case dynamicError
    case dynamicWithIncludeError
    case dynamicWithExcludeError
}
```
- We call a method with a closure either on the static or the dynamic library to have it in our stacktrace.
- We either set nothing, include or exclude.

## Results

All frames are marked as In-App, regardless if we use inculdes/excludes or static/dynamic. At least with this setup.

### Simulator

### Debug

- staticError
  - library frames should be marked as inapp ✅
  - https://sentry-sdks.sentry.io/issues/6607440283/?project=4509327016919040&query=is%3Aunresolved%20issue.priority%3A%5Bhigh%2C%20medium%5D&referrer=issue-stream&stream_index=0

- dynamicLib
  - library frames should not be marked as inapp ❌ Incorrectly marked as in-app
  - https://sentry-sdks.sentry.io/issues/6607452572/?project=4509327016919040&query=is%3Aunresolved%20issue.priority%3A%5Bhigh%2C%20medium%5D&referrer=issue-stream&stream_index=0

- dynamicWithIncludeError
  - library frames should be marked as inapp ✅
  - https://sentry-sdks.sentry.io/issues/6607455294/?project=4509327016919040&query=is%3Aunresolved%20issue.priority%3A%5Bhigh%2C%20medium%5D&referrer=issue-stream&stream_index=0

- dynamicWithExcludeError
  - library frames should not be marked as inapp ❌ Incorrectly marked as in-app
  - https://sentry-sdks.sentry.io/issues/6607457469/?project=4509327016919040&query=is%3Aunresolved%20issue.priority%3A%5Bhigh%2C%20medium%5D&referrer=issue-stream&stream_index=0

### Release (Run as Release in Scheme)

- dynamicLib
  - library frames should not be marked as inapp ❌ Incorrectly marked as in-app
  - https://sentry-sdks.sentry.io/issues/6607513983/events/latest/?project=4509327016919040&query=is%3Aunresolved%20issue.priority%3A%5Bhigh%2C%20medium%5D&referrer=latest-event&stream_index=0

- dynamicWithExcludeError
  - library frames should not be marked as inapp ❌ Incorrectly marked as in-app
  - https://sentry-sdks.sentry.io/issues/6607452572/events/latest/?project=4509327016919040&query=is%3Aunresolved%20issue.priority%3A%5Bhigh%2C%20medium%5D&referrer=latest-event&stream_index=0

### Device + Custom Rules

Debug builds.

```
family:native package:/var/containers/Bundle/Application/*/*.app/Frameworks/*.framework/** -app
family:native package:/private/var/containers/Bundle/Application/*/*.app/Frameworks/*.framework/** -app
```

- dynamicLib
  - library frames should not be marked as inapp ✅
  - https://sentry-sdks.sentry.io/issues/6607513983/events/latest/?project=4509327016919040&query=is%3Aunresolved%20issue.priority%3A%5Bhigh%2C%20medium%5D&referrer=latest-event&stream_index=0

![device_dyn_rules](img/device_dyn_rules.png)

- dynamicWithIncludeError
  - library frames should be marked as inapp, but rules override it ❌/✅
  - https://sentry-sdks.sentry.io/issues/6607516553/events/latest/?project=4509327016919040&query=is%3Aunresolved%20issue.priority%3A%5Bhigh%2C%20medium%5D&referrer=latest-event&stream_index=0

![device_dyn_incl_rules](img/device_dyn_incl_rules.png)

- dynamicWithExcludeError
  - library frames should not be marked as inapp ✅
  - https://sentry-sdks.sentry.io/issues/6607452572/events/latest/?project=4509327016919040&query=is%3Aunresolved%20issue.priority%3A%5Bhigh%2C%20medium%5D&referrer=latest-event&stream_index=0

![device_dyn_excl_rules](img/device_dyn_excl_rules.png)

### Device without Custom Rules

Debug build.

![Lib Path](img/lib_path.png)

- dynamicLib
  - library frames should not be marked as inapp ❌
  - https://sentry-sdks.sentry.io/issues/6607513983/events/latest/?project=4509327016919040&query=is%3Aunresolved%20issue.priority%3A%5Bhigh%2C%20medium%5D&referrer=latest-event&stream_index=0

![device_dyn](img/device_dyn.png)

- dynamicWithIncludeError
  - library frames should be marked as inapp ✅
  - https://sentry-sdks.sentry.io/issues/6607516553/events/latest/?project=4509327016919040&query=is%3Aunresolved%20issue.priority%3A%5Bhigh%2C%20medium%5D&referrer=latest-event&stream_index=0

![device_dyn_incl](img/device_dyn_incl.png)

- dynamicWithExcludeError
  - library frames should not be marked as inapp ❌ Incorrectly marked as in-app
  - https://sentry-sdks.sentry.io/issues/6607452572/events/latest/?project=4509327016919040&query=is%3Aunresolved%20issue.priority%3A%5Bhigh%2C%20medium%5D&referrer=latest-event&stream_index=0

![device_dyn_excl](img/device_dyn_excl.png) 

