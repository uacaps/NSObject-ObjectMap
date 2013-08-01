//
//  NSObject+ObjectMap.h
//
//  Created by Benjamin Gordon on 5/8/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define OMDateFormat @"yyyy-MM-dd HH:mm:ss.S"
#define OMTimeZone @"UTC"

@interface NSScanner (XMLScan)
-(BOOL)isAtEndOfTag:(NSString *)tag;
-(NSString *)nextXMLTag;
-(void)skipTag:(NSString *)tag;
-(NSString *)getNextValue;
@end

@interface NSObject (ObjectMap)

// Universal Method
-(NSDictionary *)propertyDictionary;
-(NSString *)nameOfClass;

// JSON -> Object
+(id)objectOfClass:(NSString *)object fromJSON:(NSDictionary *)dict;
+(NSArray *)arrayFromJSON:(NSArray *)jsonArray ofObjects:(NSString *)obj;

// XML -> Object
+(id)objectOfClass:(NSString *)object fromXML:(NSString *)xml;

//Object -> Data
-(NSDictionary *)objectDictionary;
-(NSData *)JSONData;
-(NSString *)JSONString;

// XML-SOAP
-(NSData *)XMLData;
-(NSData *)SOAPData;

// For mapping an array to properties
-(NSMutableDictionary *)getPropertyArrayMap;

// Copying an NSObject to new memory ref
// (basically initWithObject)
-(id)initWithObject:(NSObject *)oldObject error:(NSError **)error;

// Base64 Encode/Decode
+(NSString *)encodeBase64WithData:(NSData *)objData;
+(NSData *)base64DataFromString:(NSString *)string;

// Helpers
-(NSString *)typeFromProperty:(objc_property_t)property;

@end

@interface SOAPObject : NSObject
@property (nonatomic, retain) id Header;
@property (nonatomic, retain) id Body;
@end