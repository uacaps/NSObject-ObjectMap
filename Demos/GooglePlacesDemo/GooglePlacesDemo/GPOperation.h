//
//  GPOperation.h
//  GooglePlacesDemo
//
//  Created by Matthew York on 8/1/13.
//  Copyright (c) 2013 Matt York. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPOperation : NSOperation

@property (nonatomic, retain) NSString *methodPath;
@property (nonatomic, retain) NSData *bodyData;
@property (nonatomic, retain) NSData *responseData;
@property (nonatomic, retain) NSMutableURLRequest *request;


-(void)setMethodPath:(NSString *)path data:(NSData *)bodyData completion:(void (^)(void))block;

@end
