# travis_report

Get the [Travis CI](https://travis-ci.org/) build status for a list of projects :construction_worker:

![](http://i.giphy.com/yoJC2pxpca0K6v67qo.gif)

[![Build Status](https://travis-ci.org/dkhamsing/travis_report.svg)](https://travis-ci.org/dkhamsing/travis_report)

## Installation

```shell
$ git clone https://github.com/dkhamsing/travis_report.git
$ cd travis_report
$ rake install # 🎉
```

## Usage

```
travis_report <file> [--fail] [--new]
```

```
$ travis_report projects.txt

Collecting reports for 10 projects
✅  vsouza/awesome-ios
   Passing
   1 day ago 2016-01-28 19:40:05 -0800
   Duration: 28 seconds
   Shohei Yokoyama: Update README.md
   https://travis-ci.org/vsouza/awesome-ios/builds/105594263
✅  dkhamsing/awesome_bot
   Passing
   1 day ago 2016-01-28 09:49:22 -0800
   Duration: 17 seconds
   dkhamsing: Delete status.md
   https://travis-ci.org/dkhamsing/awesome_bot/builds/105475846
✅  matteocrippa/awesome-swift
   Passing
   1 day ago 2016-01-28 07:27:55 -0800
   Duration: 20 seconds
   dkhamsing: Move file to assets
   https://travis-ci.org/matteocrippa/awesome-swift/builds/105442710
🔴  ziadoz/awesome-php
   Failing
   today 2016-01-29 07:55:29 -0800
   Duration: 1 minute
   Jamie York: Add semver to contribution guidelines
   https://travis-ci.org/ziadoz/awesome-php/builds/105702466
✅  dkhamsing/open-source-ios-apps
   Passing
   today 2016-01-29 07:34:42 -0800
   Duration: 31 seconds
   dkhamsing: Merge pull request #210 from dkhamsing/communication
   https://travis-ci.org/dkhamsing/open-source-ios-apps/builds/105697642
...
```

Example input file (one project per line).

```
$ cat projects.txt

dkhamsing/awesome_bot
dkhamsing/open-source-ios-apps
vsouza/awesome-ios
https://github.com/matteocrippa/awesome-swift
ziadoz/awesome-php
```

## TODO

- check default branch
- check pull requests
- display travis log
- work on library
- output markdown table

## Credits

- `travis.rb` and [more](travis_report.gemspec)
- [giphy](http://gph.is/1JB8rpw)

## Contact

- [github.com/dkhamsing](https://github.com/dkhamsing)
- [twitter.com/dkhamsing](https://twitter.com/dkhamsing)

## License

This project is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
