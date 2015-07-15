# WPFaker

*WBFaker* is a Post library that builds on top of [MBFaker](https://github.com/bananita/MBFaker) and adds a handful of additional methods that are helpful for our apps.

It was originally created as a result of [IPADRAIN-165](http://jira.wpprivate.com/browse/IPADRAIN-165).

The main classes are:

### Dates 
```objc
Dates *myDates = [[Dates alloc] init];

NSString *dateString1 = [myDates minutesAgo:1 options:TestDatesFormatDefault];
    // @"Thu, 15 Jan 2015 04:17:47 GMT"
NSNumber *dateNumber = [myDates minutesAgoAsEpoch:123];
    // @1421288147027
NSString *dateString2 = [myDates minutesAgo:123];
    // @"Thu, 15 Jan 2015 02:15:47 GMT"
NSString *dateString3 = [myDates minutesAgo:123 options:TestDatesFormatTwitter];
    // @"Thu Jan 15 02:15:47 GMT 2015"
NSDate *date1 = [myDates minutesAgoAsDate:123];
    // 2015-01-15 02:15:47 +0000
NSDate *date2 = [myDates dateFromString:@"Thu, 15 Jan 2015 04:16:11 GMT" options:TestDatesFormatDefault];
    // 2015-01-15 04:16:11 +0000
```

### RandomNumber
```objc
RandomNumber *random = [[RandomNumber alloc] init];

NSNumber *rNumber = [random inRange:10 high:50];
    // @43
NSString *idString = [random twitterIdStr];
    // @"84221673"
```


### WPFakerInternet Extensions
```objc
NSString *path = [MBFakerInternet path];
    // @"/marta/nina/nova/felipa/joy.o'connell"
NSString *uuid = [MBFakerInternet uuid];
    // @"020EA377-085C-4E84-A90F-7F61CE07273D"
```
