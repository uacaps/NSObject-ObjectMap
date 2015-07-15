//
//  ClangHelper.h
//  WashPost
//
//  Created by Soper, Sean on 10/20/14.
//  Copyright (c) 2014 Washington Post. All rights reserved.
//

#ifndef SuppressPerformSelectorLeakWarning
#define SuppressPerformSelectorLeakWarning(Stuff) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    Stuff; \
    _Pragma("clang diagnostic pop")
#endif

#ifndef SuppressUnusedVariableWarning
#define SuppressUnusedVariableWarning(Stuff) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wunused-variable\"") \
    Stuff; \
    _Pragma("clang diagnostic pop")
#endif

#ifndef SuppressUndeclaredSelectorWarning
#define SuppressUndeclaredSelectorWarning(Stuff) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
    Stuff; \
    _Pragma("clang diagnostic pop")
#endif
