# JRRegexKitLite

[![CI Status](https://img.shields.io/travis/yu0winter/JRRegexKitLite.svg?style=flat)](https://travis-ci.org/yu0winter/JRRegexKitLite)
[![Version](https://img.shields.io/cocoapods/v/JRRegexKitLite.svg?style=flat)](https://cocoapods.org/pods/JRRegexKitLite)
[![License](https://img.shields.io/cocoapods/l/JRRegexKitLite.svg?style=flat)](https://cocoapods.org/pods/JRRegexKitLite)
[![Platform](https://img.shields.io/cocoapods/p/JRRegexKitLite.svg?style=flat)](https://cocoapods.org/pods/JRRegexKitLite)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JRRegexKitLite is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JRRegexKitLite'
```
## Edit

- 本地检查私有库：（下面是一个比较通用的写法）
```
pod lib lint --verbose --use-libraries --allow-warnings --sources='https://github.com/CocoaPods/Specs.git,http://jcode.cbpmgt.com/git/jrMobileRepo.git'
```

- 最后执行远端检查私有库：
```
pod spec lint --verbose --use-libraries --allow-warnings --sources='https://github.com/CocoaPods/Specs.git,http://jcode.cbpmgt.com/git/jrMobileRepo.git'
```
远端检查一定和本地检查使用相同的参数，只是将pod lib 换成了 pod spec而已。
- 当远端检查通过后，就可以将私有库添加到Repo仓库中：
```
pod repo push cbpmgt-git-jrmobilerepo JRRegexKitLite.podspec --verbose --use-libraries --allow-warnings --sources='https://github.com/CocoaPods/Specs.git,http://jcode.cbpmgt.com/git/jrMobileRepo.git'
```
## Author

yu0winter, niuyulong@jd.com

## License

JRRegexKitLite is available under the MIT license. See the LICENSE file for more info.
