//Copyright (c) 2012 The Board of Trustees of The University of Alabama
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions
//are met:
//
//1. Redistributions of source code must retain the above copyright
//notice, this list of conditions and the following disclaimer.
//2. Redistributions in binary form must reproduce the above copyright
//notice, this list of conditions and the following disclaimer in the
//documentation and/or other materials provided with the distribution.
//3. Neither the name of the University nor the names of the contributors
//may be used to endorse or promote products derived from this software
//without specific prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
//FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
//THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
//HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
//STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
//OF THE POSSIBILITY OF SUCH DAMAGE.


#import "NSObject+ObjectMap.h"

static const char _base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short _base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
    -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};


@implementation NSObject (ObjectMap)

#pragma mark - XML to Object
+(id)objectOfClass:(NSString *)object fromXML:(NSString *)xml {
    
    //Create new instance of desired object
    id newObject = [[NSClassFromString(object) alloc] init];
    
    //Get all properties for that new object
    NSDictionary *mapDictionary = [newObject propertyDictionary];
    
    //Iterate over all properties and read in their values recursively
    for (NSString *key in [mapDictionary allKeys]) {
        //Get class name
        objc_property_t property = class_getProperty([newObject class], [key UTF8String]);
        NSString *className = [[newObject typeFromProperty:property] substringWithRange:NSMakeRange(3, [newObject typeFromProperty:property].length - 4)];
        
        //If the key is a primitive or for some reason there was a problem getting the class name, go ahead and skip this property, else get it's node value
        if (className) {
            //Create blank object to be filled by type
            id objForKey;
            
            // Check Types
            if ([className isEqualToString:@"NSString"]) {
                objForKey = [[NSString alloc] init];
            }
            else if ([className isEqualToString:@"NSDate"]) {
                objForKey = [NSDate date];
            }
            else if ([className isEqualToString:@"NSNumber"]) {
                objForKey = [[NSNumber alloc] initWithFloat:0.00];
            }
            else if ([className isEqualToString:@"NSArray"]) {
                objForKey = [[NSArray alloc] init];
            }
            else if ([className isEqualToString:@"NSData"]){
                objForKey = [[NSData alloc] init];
            }
            else if ([className isEqualToString:@"NSDictionary"]) {
                continue;
            }
            else {
                objForKey = [[NSClassFromString(className) alloc] init];
            }
            
            // Create
            [newObject setValue:[objForKey getNodeValue:key fromXML:xml] forKey:key];
        }
    }
    
    return newObject;
}

-(id)getNodeValue:(NSString *)node fromXML:(NSString *)xml {
    NSString *trash = @"";
    NSString *value = nil;
    NSScanner *xmlScanner = [NSScanner scannerWithString:xml];
    [xmlScanner scanUpToString:[NSString stringWithFormat:@"<%@", node] intoString:&trash];
    [xmlScanner scanUpToString:@">" intoString:&trash];
    [xmlScanner scanString:@">" intoString:&trash];
    
    // Check property type
    if ([self isKindOfClass:[NSArray class]]) {
        // Set up a new scanner for xml substring
        [xmlScanner scanUpToString:[NSString stringWithFormat:@"</%@", node] intoString:&value];
        NSString *filteredArrayObj = @"";
        NSScanner *checkTypeScanner = [NSScanner scannerWithString:value];
        [checkTypeScanner scanString:@"<" intoString:&trash];
        [checkTypeScanner scanUpToString:@">" intoString:&filteredArrayObj];
        NSScanner *insideArrayScanner = [NSScanner scannerWithString:value];
        NSString *newValue = @"";
        NSMutableArray *objArray = [@[] mutableCopy];
        
        // Scan and create objects until you can't no mo'
        while (![insideArrayScanner isAtEnd]) {
            //Remove additional XML attributes from parsing
            if ([filteredArrayObj rangeOfString:@" "].location != NSNotFound) {
                filteredArrayObj = [filteredArrayObj substringToIndex:[filteredArrayObj rangeOfString:@" "].location];
            }
            
            [insideArrayScanner scanUpToString:[NSString stringWithFormat:@"<%@", filteredArrayObj] intoString:&trash];
            [insideArrayScanner scanUpToString:@">" intoString:&trash];
            [insideArrayScanner scanString:@">" intoString:&trash];
            [insideArrayScanner scanUpToString:[NSString stringWithFormat:@"</%@", filteredArrayObj] intoString:&newValue];
            
            // Create Object
            if ([filteredArrayObj isEqualToString:@"string"]) {
                [objArray addObject:(NSString *)newValue];
            }
            else if ([filteredArrayObj isEqualToString:@"int"] || [filteredArrayObj isEqualToString:@"float"] || [filteredArrayObj isEqualToString:@"double"] || [filteredArrayObj isEqualToString:@"long"]){
                [objArray addObject:[NSNumber numberWithDouble:((NSString *)newValue).doubleValue]];
            }
            else {
                id object = [NSObject objectOfClass:filteredArrayObj fromXML:newValue];
                if (object){
                    [objArray addObject:object];
                }
            }
            
            // Scan until nextNode
            [insideArrayScanner scanString:[NSString stringWithFormat:@"</%@", filteredArrayObj] intoString:&trash];
            [insideArrayScanner scanUpToString:@">" intoString:&trash];
            [insideArrayScanner scanString:@">" intoString:&trash];
        }
        
        // Return the array
        return objArray;
    }
    
    // Self is a number
    else if ([self isKindOfClass:[NSNumber class]]) {
        [xmlScanner scanUpToString:@"</" intoString:&value];
        if ([value isEqualToString:@"true"]) {
            return [NSNumber numberWithBool:YES];
        }
        else if ([value isEqualToString:@"false"]){
            return [NSNumber numberWithBool:NO];
        }
        
        if (value) {
            return [NSNumber numberWithFloat:[value floatValue]];
        }
        else {
            return nil;
        }
    }
    
    // Self is a string
    else if ([self isKindOfClass:[NSString class]]) {
        [xmlScanner scanUpToString:@"</" intoString:&value];
        return value;
    }
    
    // Self is a date
    else if ([self isKindOfClass:[NSDate class]]) {
        [xmlScanner scanUpToString:@"</" intoString:&value];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:OMDateFormat];
        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:OMTimeZone]];
        return [formatter dateFromString:value];
    }
    
    // Self is Data
    else if ([self isKindOfClass:[NSData class]]){
        [xmlScanner scanUpToString:@"</" intoString:&value];
        return [NSObject base64DataFromString:value];
    }
    
    // Custom NSObject
    //If it has the same name as the object type
    else if ([self isKindOfClass:[NSClassFromString(node) class]]) {
        [xmlScanner scanUpToString:[NSString stringWithFormat:@"</%@", node] intoString:&value];
        return [NSObject objectOfClass:node fromXML:value];
    }
    //If the type name is different from the object name
    else {
        [xmlScanner scanUpToString:[NSString stringWithFormat:@"</%@", node] intoString:&value];
        return [NSObject objectOfClass:NSStringFromClass([self class]) fromXML:value];
    }
    
    return nil;
}


#pragma mark - JSONData to Object
+ (id)objectOfClass:(NSString *)object fromJSONData:(NSData *)jsonData {
    NSError *error;
    id newObject = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    // If jsonObject is a top-level object already
    if([jsonObject isKindOfClass:[NSDictionary class]]) {
        newObject = [NSObject objectOfClass:object fromJSON:jsonObject];
    }
    // Else it is an array of objects
    else if([jsonObject isKindOfClass:[NSArray class]]){
        int length = [((NSArray*) jsonObject) count];
        NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:length];
        for(int i = 0; i < length; i++){
            [resultArray addObject:[NSObject objectOfClass:object fromJSON:[(NSArray*)jsonObject objectAtIndex:i]]];
        }
        newObject = [[NSArray alloc] initWithArray:resultArray];
    }
    
    return newObject;
}


#pragma mark - Dictionary to Object
+(id)objectOfClass:(NSString *)object fromJSON:(NSDictionary *)dict {
    if([object isEqualToString:@"NSDictionary"]){
        return dict;
    }
    
    id newObject = [[NSClassFromString(object) alloc] init];
    NSDictionary *mapDictionary = [newObject propertyDictionary];
    
    for (NSString *key in [dict allKeys]) {
        NSString *propertyName = [mapDictionary objectForKey:key];
        
        if (!propertyName) {
            continue;
        }
        
        // If it's null, set to nil and continue
        if ([dict objectForKey:key] == [NSNull null]) {
            [newObject setValue:nil forKey:propertyName];
            continue;
        }
        
        // If it's a Dictionary, make into object
        if ([[dict objectForKey:key] isKindOfClass:[NSDictionary class]]) {
            //id newObjectProperty = [newObject valueForKey:propertyName];
            NSString *propertyType = [newObject classOfPropertyNamed:propertyName];
            id nestedObj = [NSObject objectOfClass:propertyType fromJSON:[dict objectForKey:key]];
            [newObject setValue:nestedObj forKey:propertyName];
        }
        
        // If it's an array, check for each object in array -> make into object/id
        else if ([[dict objectForKey:key] isKindOfClass:[NSArray class]]) {
            NSArray *nestedArray = [dict objectForKey:key];
            NSString *propertyType = [newObject valueForKeyPath:[NSString stringWithFormat:@"propertyArrayMap.%@", key]];
            [newObject setValue:[NSObject arrayMapFromArray:nestedArray forPropertyName:propertyType] forKey:propertyName];
        }
        
        // Add to property name, because it is a type already
        else {
            objc_property_t property = class_getProperty([newObject class], [propertyName UTF8String]);
            
            if (property) {
                NSString *classType = [newObject typeFromProperty:property];
                
                // check if NSDate or not
                if ([classType isEqualToString:@"T@\"NSDate\""]) {
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:OMDateFormat];
                    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:OMTimeZone]];
                    [newObject setValue:[formatter dateFromString:[dict objectForKey:key]] forKey:propertyName];
                }
                else {
                    [newObject setValue:[dict objectForKey:key] forKey:propertyName];
                }
            }
        }
    }
    
    return newObject;
}

-(NSString *)classOfPropertyNamed:(NSString *)propName {
    objc_property_t theProperty = class_getProperty([self class], [propName UTF8String]);
    NSString *className = [NSString stringWithFormat:@"%s", getPropertyType(theProperty)];
    return className;
}


static const char * getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "";
}

+(NSArray *)arrayFromJSON:(NSArray *)jsonArray ofObjects:(NSString *)obj {
    //NSString *filteredObject = [NSString stringWithFormat:@"%@s",obj];
    return [NSObject arrayMapFromArray:jsonArray forPropertyName:obj];
}

-(NSString *)nameOfClass {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

+(NSArray *)arrayMapFromArray:(NSArray *)nestedArray forPropertyName:(NSString *)propertyName {
    // Set Up
    NSMutableArray *objectsArray = [@[] mutableCopy];
    
    // Create objects
    for (int xx = 0; xx < nestedArray.count; xx++) {
        // If it's an NSDictionary
        if ([nestedArray[xx] isKindOfClass:[NSDictionary class]]) {
            // Create object of filteredProperty type
            id nestedObj = [[NSClassFromString(propertyName) alloc] init];
            
            // Iterate through each key, create objects for each
            for (NSString *newKey in [nestedArray[xx] allKeys]) {
                // If it's null, move on
                if ([nestedArray[xx] objectForKey:newKey] == [NSNull null]) {
                    [nestedObj setValue:nil forKey:newKey];
                    continue;
                }
                
                // If it's an Array, recur
                if ([[nestedArray[xx] objectForKey:newKey] isKindOfClass:[NSArray class]]) {
                    NSString *propertyType = [nestedObj valueForKeyPath:[NSString stringWithFormat:@"propertyArrayMap.%@", newKey]];
                    [nestedObj setValue:[NSObject arrayMapFromArray:[nestedArray[xx] objectForKey:newKey]  forPropertyName:propertyType] forKey:newKey];
                }
                // If it's a Dictionary, create an object, and send to [self objectFromJSON]
                else if ([[nestedArray[xx] objectForKey:newKey] isKindOfClass:[NSDictionary class]]) {
                    NSString *type = [nestedObj classOfPropertyNamed:newKey];
                    
                    id nestedDictObj = [NSObject objectOfClass:type fromJSON:[nestedArray[xx] objectForKey:newKey]];
                    [nestedObj setValue:nestedDictObj forKey:newKey];
                }
                // Else, it is an object
                else {
                    objc_property_t property = class_getProperty([NSClassFromString(propertyName) class], [newKey UTF8String]);
                    
                    if (property) {
                        NSString *classType = [self typeFromProperty:property];
                        // check if NSDate or not
                        if ([classType isEqualToString:@"T@\"NSDate\""]) {
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:OMDateFormat];
                            [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:OMTimeZone]];
                            [nestedObj setValue:[formatter dateFromString:[nestedArray[xx] objectForKey:newKey]] forKey:newKey];
                        }
                        else {
                            [nestedObj setValue:[nestedArray[xx] objectForKey:newKey] forKey:newKey];
                        }
                    }
                    
                }
            }
            
            // Finally add that object
            [objectsArray addObject:nestedObj];
        }
        
        // If it's an NSArray, recur
        else if ([nestedArray[xx] isKindOfClass:[NSArray class]]) {
            [objectsArray addObject:[NSObject arrayMapFromArray:nestedArray[xx] forPropertyName:propertyName]];
        }
        
        // Else, add object directly
        else {
            [objectsArray addObject:nestedArray[xx]];
        }
    }
    
    // This is now an Array of objects
    return objectsArray;
}

-(NSDictionary *)propertyDictionary {
    // Add properties of Self
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        [dict setObject:key forKey:key];
    }
    
    free(properties);
    
    // Add all superclass properties of Self as well, until it hits NSObject
    NSString *superClassName = [[self superclass] nameOfClass];
    if (![superClassName isEqualToString:@"NSObject"]) {
        for (NSString *property in [[[self superclass] propertyDictionary] allKeys]) {
            [dict setObject:property forKey:property];
        }
    }
    
    // Return the Dict
    return dict;
}

-(NSString *)typeFromProperty:(objc_property_t)property {
    return [[NSString stringWithUTF8String:property_getAttributes(property)] componentsSeparatedByString:@","][0];
}


#pragma mark - Get Property Array Map
// This returns an associated property Dictionary for objects
// You should make an object contain a dictionary in init
// that contains a map for each array and what it contains:
//
// {"arrayPropertyName":"TypeOfObjectYouWantInArray"}
//
// To Set this object in each init method, do something like this:
//
// [myObject setValue:@"TypeOfObjectYouWantInArray" forKeyPath:@"propertyArrayMap.arrayPropertyName"]
//
-(NSMutableDictionary *)getPropertyArrayMap {
    if (objc_getAssociatedObject(self, @"propertyArrayMap")==nil) {
        objc_setAssociatedObject(self,@"propertyArrayMap",[[NSMutableDictionary alloc] init],OBJC_ASSOCIATION_RETAIN);
    }
    return (NSMutableDictionary *)objc_getAssociatedObject(self, @"propertyArrayMap");
}


#pragma mark - Copy NSObject (initWithObject)
-(id)initWithObject:(NSObject *)oldObject error:(NSError **)error {
    NSString *oldClassName = [oldObject nameOfClass];
    NSString *newClassName = [self nameOfClass];
    
    if ([newClassName isEqualToString:oldClassName]) {
        for (NSString *propertyKey in [[oldObject propertyDictionary] allKeys]) {
            [self setValue:[oldObject valueForKey:propertyKey] forKey:propertyKey];
        }
    }
    else {
        *error = [NSError errorWithDomain:@"MismatchedObjects" code:404 userInfo:@{@"Error":@"Mismatched Object Classes"}];
    }
    
    return self;
}


#pragma mark - Object to Data/String/etc.

-(NSDictionary *)objectDictionary {
    NSMutableDictionary *objectDict = [@{} mutableCopy];
    for (NSString *key in [[self propertyDictionary] allKeys]) {
        [objectDict setValue:[self valueForKey:key] forKey:key];
    }
    return objectDict;
}

-(NSData *)JSONData{
    id dict = [NSObject jsonDataObjects:self];
    return [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
}

-(NSString *)JSONString{
    id dict = [NSObject jsonDataObjects:self];
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
}

+ (id)jsonDataObjects:(id)obj {
    id returnProperties = nil;
    if([self isArray:obj]) {
        int length =[(NSArray*)obj count];
        returnProperties = [NSMutableArray arrayWithCapacity:length];
        for(int i = 0; i < length; i++){
            [returnProperties addObject:[NSObject dictionaryWithPropertiesOfObject:[(NSArray*)obj objectAtIndex:i]]];
        }
    }
    else {
        returnProperties = [NSObject dictionaryWithPropertiesOfObject:obj];
        
    }
    
    return returnProperties;
}

+(NSDictionary *)dictionaryWithPropertiesOfObject:(id)obj
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSMutableArray *propertiesArray = [NSObject propertiesArrayFromObject:obj];
    
    for (int i = 0; i < propertiesArray.count; i++) {
        NSString *key = propertiesArray[i];
        
        if (![obj valueForKey:key]) {
            continue;
        }
        
        if ([self isArray:obj key:key]) {
            [dict setObject:[self arrayForObject:[obj valueForKey:key]] forKey:key];
        }
        else if ([self isDate:[obj valueForKey:key]]){
            [dict setObject:[self dateForObject:[obj valueForKey:key]] forKey:key];
        }
        else if ([self isSystemObject:obj key:key]) {
            [dict setObject:[obj valueForKey:key] forKey:key];
        }
        else if ([NSObject isData:[obj valueForKey:key]]){
            [dict setObject:[NSObject encodeBase64WithData:[obj valueForKey:key]] forKey:key];
        }
        else {
            [dict setObject:[self dictionaryWithPropertiesOfObject:[obj valueForKey:key]] forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

+(NSMutableArray *)propertiesArrayFromObject:(id)obj {
    
    NSMutableArray *props = [NSMutableArray array];
    
    if (!obj) {
        return props;
    }
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    for (int i = 0; i < count; i++) {
        [props addObject:[NSString stringWithUTF8String:property_getName(properties[i])]];
    }
    
    free(properties);
    
    NSString *superClassName = [[obj superclass] nameOfClass];
    if (![superClassName isEqualToString:@"NSObject"]) {
        [props addObjectsFromArray:[NSObject propertiesArrayFromObject:[[NSClassFromString(superClassName) alloc] init]]];
    }
    
    return props;
}

-(BOOL)isSystemObject:(id)obj key:(NSString *)key{
    if ([[obj valueForKey:key] isKindOfClass:[NSString class]] || [[obj valueForKey:key] isKindOfClass:[NSNumber class]] || [[obj valueForKey:key] isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)isSystemObject:(id)obj{
    if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)isArray:(id)obj key:(NSString *)key{
    if ([[obj valueForKey:key] isKindOfClass:[NSArray class]]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)isArray:(id)obj{
    if ([obj isKindOfClass:[NSArray class]]) {
        return YES;
    }
    
    return NO;
}

+(BOOL)isDate:(id)obj{
    if ([obj isKindOfClass:[NSDate class]]) {
        return YES;
    }
    
    return NO;
}

+(BOOL)isData:(id)obj{
    if ([obj isKindOfClass:[NSData class]]) {
        return YES;
    }
    
    return NO;
}

-(BOOL)isData:(id)obj{
    if ([obj isKindOfClass:[NSData class]]) {
        return YES;
    }
    
    return NO;
}

+(NSArray *)arrayForObject:(id)obj{
    NSArray *ContentArray = (NSArray *)obj;
    NSMutableArray *objectsArray = [[NSMutableArray alloc] init];
    for (int ii = 0; ii < ContentArray.count; ii++) {
        if ([self isArray:ContentArray[ii]]) {
            [objectsArray addObject:[self arrayForObject:[ContentArray objectAtIndex:ii]]];
        }
        else if ([self isDate:ContentArray[ii]]){
            [objectsArray addObject:[self dateForObject:[ContentArray objectAtIndex:ii]]];
        }
        else if ([self isSystemObject:[ContentArray objectAtIndex:ii]]) {
            [objectsArray addObject:[ContentArray objectAtIndex:ii]];
        }
        else {
            [objectsArray addObject:[self dictionaryWithPropertiesOfObject:[ContentArray objectAtIndex:ii]]];
        }
        
    }
    
    return objectsArray;
}


+(NSString *)dateForObject:(id)obj{
    NSDate *date = (NSDate *)obj;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:OMDateFormat];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:OMTimeZone]];
    return [formatter stringFromDate:date];
}

#pragma mark - SOAP/XML Serialization

-(NSData *)SOAPData{
    return [[self SOAPString] dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSData *)XMLData{
    return [[self XMLString] dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSString *)XMLString{
    NSMutableString *xmlString = [@"<?xml version=\"1.0\"?>" mutableCopy];
    [xmlString appendString:[self xmlStringForSelfNamed:nil]];
    return xmlString;
}

-(NSString *)SOAPString{
    return [self soapStringForDictionary:(SOAPObject *)self];
}

-(NSString *)soapStringForDictionary:(SOAPObject *)obj{
    // No object, return blank
    if (!obj) {
        return @"";
    }
    
    // Build object
    SOAPObject *soapObject = (SOAPObject *)self;
    NSMutableString *soapString = [[NSMutableString alloc] initWithString:@""];
    
    //Open Envelope
    [soapString appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"http://tempuri.org/\">"];
    
    //Request Header
    if (obj.Header) {
        if (soapObject.Header) {
            // Add SoapHeader
            [soapString appendString:@"<soap:Header>"];
            [soapString appendString:[soapObject.Header xmlStringForSelfNamed:nil]];
            [soapString appendString:@"</soap:Header>"];
        }
    }
    
    
    if (obj.Body) {
        if (soapObject.Body) {
            // Add SoapBody
            [soapString appendString:@"<soap:Body>"];
            [soapString appendString:[obj.Body xmlStringForSelfNamed:nil]];
            [soapString appendString:@"</soap:Body>"];
        }
    }
    
    //Close Envelope
    [soapString appendString:@"</soap:Envelope>"];
    
    return soapString;
}

#pragma mark - XMLString for Self (The Meat of the Operation)
// Doesn't include <xml> or <soap> cruft - just the inside material
- (NSString *)xmlStringForSelfNamed:(NSString *)name {
    // XML doesn't handle NSDictionaries (to SPEC)
    if ([self isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    
    NSMutableString *xmlString = [[NSMutableString alloc] initWithString:@""];
    NSString *className = name ? name : [NSString stringWithFormat:@"%s", class_getName([self class])];
    className = [className stringByReplacingOccurrencesOfString:@"ArrayOf" withString:@""];
    
    // Make opening tag
    [xmlString appendFormat:@"<%@>", className];
    
    // self is a Date
    if ([self isKindOfClass:[NSDate class]]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:OMDateFormat];
        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:OMTimeZone]];
        [xmlString appendString:[formatter stringFromDate:(NSDate *)self]];
    }
    
    // self is a String or Number
    else if ([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSNumber class]]) {
        [xmlString appendFormat:@"%@", self];
    }
    
    // self is an Array
    else if ([self isKindOfClass:[NSArray class]]) {
        for (id arrayObj in (NSArray *)self) {
            [xmlString appendString:[arrayObj xmlStringForSelfNamed:nil]];
        }
    }
    
    // self is a Dictionary
    else if ([self isKindOfClass:[NSDictionary class]]) {
        for (NSString *key in [(NSDictionary *)self allKeys]) {
            [xmlString appendString:[[(NSDictionary *)self objectForKey:key] xmlStringForSelfNamed:key]];
        }
    }
    
    // self is Data
    else if ([self isKindOfClass:[NSData class]]) {
        [xmlString appendString:[NSObject encodeBase64WithData:(NSData *)self]];
    }
    
    // self is a custom Object
    else {
        NSDictionary *dict = [NSObject dictionaryWithPropertiesOfObject:self];
        for (NSString *innerObj in dict.allKeys) {
            // if innerObj exists, use it
            if ([self valueForKey:innerObj]) {
                [xmlString appendString:[[self valueForKey:innerObj] xmlStringForSelfNamed:innerObj]];
            }
            else {
                [xmlString appendFormat:@"<%@ />", innerObj];
            }
        }
    }
    
    // Append end of class name
    [xmlString appendFormat:@"</%@>", className];
    return xmlString;
}


#pragma mark - Base64 Binary Encode/Decode

+(NSData *)base64DataFromString:(NSString *)string {
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[3];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (string == nil) {
        return [NSData data];
    }
    
    ixtext = 0;
    tempcstring = (const unsigned char *)[string UTF8String];
    lentext = [string length];
    theData = [NSMutableData dataWithCapacity: lentext];
    ixinbuf = 0;
    
    while (true) {
        if (ixtext >= lentext) {
            break;
        }
        
        ch = tempcstring [ixtext++];
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        }
        else if (ch == '+') {
            ch = 62;
        }
        else if (ch == '=') {
            flendtext = true;
        }
        else if (ch == '/') {
            ch = 63;
        }
        else {
            flignore = true;
        }
        
        if (!flignore) {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext) {
                if (ixinbuf == 0) {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                }
                else {
                    ctcharsinbuf = 2;
                }
                ixinbuf = 3;
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4) {
                ixinbuf = 0;
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++) {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    return theData;
}

+ (NSString *)encodeBase64WithData:(NSData *)objData {
    const unsigned char * objRawData = [objData bytes];
    char * objPointer;
    char * strResult;
    
    // Get the Raw Data length and ensure we actually have data
    int intLength = [objData length];
    if (intLength == 0) return nil;
    
    // Setup the String-based Result placeholder and pointer within that placeholder
    strResult = (char *)calloc(((intLength + 2) / 3) * 4, sizeof(char));
    objPointer = strResult;
    
    // Iterate through everything
    while (intLength > 2) { // keep going until we have less than 24 bits
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
        *objPointer++ = _base64EncodingTable[((objRawData[1] & 0x0f) << 2) + (objRawData[2] >> 6)];
        *objPointer++ = _base64EncodingTable[objRawData[2] & 0x3f];
        
        // we just handled 3 octets (24 bits) of data
        objRawData += 3;
        intLength -= 3;
    }
    
    // now deal with the tail end of things
    if (intLength != 0) {
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        if (intLength > 1) {
            *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
            *objPointer++ = _base64EncodingTable[(objRawData[1] & 0x0f) << 2];
            *objPointer++ = '=';
        }
        else {
            *objPointer++ = _base64EncodingTable[(objRawData[0] & 0x03) << 4];
            *objPointer++ = '=';
            *objPointer++ = '=';
        }
    }
    
    // Terminate the string-based result
    *objPointer = '\0';
    
    // Return the results as an NSString object
    return [NSString stringWithCString:strResult encoding:NSUTF8StringEncoding];
}



@end


@implementation SOAPObject

@end
