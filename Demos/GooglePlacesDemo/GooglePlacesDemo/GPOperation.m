//
//  GPOperation.m
//  GooglePlacesDemo
//
//  Created by Matthew York on 8/1/13.
//  Copyright (c) 2013 Matt York. All rights reserved.
//

#import "GPOperation.h"

#define BASE_API_ADDRESS @"https://maps.googleapis.com/"

#define HTTP_METHOD_POST @"POST"
#define HTTP_METHOD_GET @"GET"
#define HTTP_METHOD_PUT @"PUT"
#define HTTP_METHOD_DELETE @"DELETE"

@implementation GPOperation

-(void)setMethodPath:(NSString *)path data:(NSData *)bodyData completion:(void (^)(void))block {
    [self setQueuePriority:NSOperationQueuePriorityHigh];
    [self setCompletionBlock:block];
    
    self.methodPath = path;
    self.bodyData = bodyData;
    self.request = [GPOperation RequestForMethod:self.methodPath withBodyData:self.bodyData forHttpMethod:HTTP_METHOD_GET];
    self.responseData = [[NSData alloc] init];
}


-(void)main {
    NSError *error;
    NSURLResponse *response;
    self.responseData = [NSURLConnection sendSynchronousRequest:self.request returningResponse:&response error:&error];
}


+(NSMutableURLRequest *)RequestForMethod:(NSString *)method withBodyData:(NSData *)data forHttpMethod:(NSString *)httpMethod{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_API_ADDRESS, method]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    [request setHTTPBody:data];
    [request setHTTPMethod:httpMethod];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

@end
