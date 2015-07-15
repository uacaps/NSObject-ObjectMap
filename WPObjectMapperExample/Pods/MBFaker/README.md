MBFaker
=====
This library is a port of Ruby's [Faker](https://github.com/stympy/faker) library that generates fake data.  

You can use it for taking real-looking test data, screenshots and populate
your database during development.

To parse language files it uses [YAML.framework](https://github.com/mirek/YAML.framework)

![iOS Screenshot](https://raw.github.com/bananita/MBFaker/master/Screenshots/ios.png)

Installation
------------
Insert line below into your Podfile:

    pod 'MBFaker'

Languages
---------
It works with original language files in yaml with small modifications.

Default language is English. You can change it with setLanguage method

    [MBFaker setLanguage:@"en"];
    
Language name is just name of file with it.

Usage
-----
```objc
#import <MBFaker/MBFaker.h>

// ...

NSString* name  = [MBFakerName name];
NSString* email = [MBFakerInternet freeEmail];
```
    
Contributing
------------
If you'd like to contribute code or formats/data for another locale, fork
the project at [github](https://github.com/bananita/mbfaker), make your changes,
then send a pull request.

License
-------
This code is free to use under the terms of the MIT license.
