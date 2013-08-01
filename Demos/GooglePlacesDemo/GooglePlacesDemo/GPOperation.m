//  Copyright (c) 2012 The Board of Trustees of The University of Alabama
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions
//  are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//  3. Neither the name of the University nor the names of the contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
//  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
//  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
//  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
//  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
//  OF THE POSSIBILITY OF SUCH DAMAGE.

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
