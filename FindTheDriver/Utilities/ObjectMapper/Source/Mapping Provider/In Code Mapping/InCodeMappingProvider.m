//
//  InCodeMappintProvider.m
//  OCMapper
//
//  Created by Aryan Gh on 4/20/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//
// https://github.com/aryaxt/OCMapper
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "InCodeMappingProvider.h"

#define KEY_FOR_ARRAY_OF_OBJECT_MAPPING_INFOS @"objectMappingInfos"

@interface InCodeMappingProvider()
@property (nonatomic, strong) NSMutableDictionary *mappingDictionary;
@property (nonatomic, strong) NSMutableDictionary *inverseMappingDictionary;
@property (nonatomic, strong) NSMutableDictionary *dateFormatterDictionary;
@property (nonatomic, strong) NSMutableDictionary *inverseDateFormatterDictionary;
@property (nonatomic, strong) NSMutableDictionary *excludeKeysDictionary;
@end

@implementation InCodeMappingProvider
@synthesize mappingDictionary;
@synthesize dateFormatterDictionary;

#pragma mark - Initialization -

- (instancetype)init
{
	if (self = [super init])
	{
		self.automaticallyGenerateInverseMapping = YES;
		self.mappingDictionary = [NSMutableDictionary dictionary];
		self.inverseMappingDictionary = [NSMutableDictionary dictionary];
		self.dateFormatterDictionary = [NSMutableDictionary dictionary];
		self.inverseDateFormatterDictionary = [NSMutableDictionary dictionary];
        self.excludeKeysDictionary = [NSMutableDictionary dictionary];
	}
	
	return self;
}

#pragma mark - Public Methods -

- (void)mapFromDictionaryKey:(NSString *)dictionaryKey toPropertyKey:(NSString *)propertyKey withObjectType:(Class)objectType forClass:(Class)class
{
	ObjectMappingInfo *info = [[ObjectMappingInfo alloc] initWithDictionaryKey:dictionaryKey propertyKey:propertyKey andObjectType:objectType];
	NSString *key = [self uniqueKeyForClass:class andKey:dictionaryKey];
	(self.mappingDictionary)[key] = info;
    
	if (self.automaticallyGenerateInverseMapping)
	{
		[self mapFromPropertyKey:propertyKey toDictionaryKey:dictionaryKey forClass:class];
	}
}

- (void)mapFromDictionaryKey:(NSString *)dictionaryKey toPropertyKey:(NSString *)propertyKey forClass:(Class)class
{
	[self mapFromDictionaryKey:dictionaryKey toPropertyKey:propertyKey withObjectType:nil forClass:class];
}

- (void)mapFromDictionaryKey:(NSString *)dictionaryKey toPropertyKey:(NSString *)propertyKey forClass:(Class)class withTransformer:(MappingTransformer)transformer
{
	ObjectMappingInfo *info = [[ObjectMappingInfo alloc] initWithDictionaryKey:dictionaryKey propertyKey:propertyKey andTransformer:transformer];
	NSString *key = [self uniqueKeyForClass:class andKey:dictionaryKey];
	(self.mappingDictionary)[key] = info;
}

- (void)mapFromPropertyKey:(NSString *)propertyKey toDictionaryKey:(NSString *)dictionaryKey forClass:(Class)class {
	ObjectMappingInfo *info = [[ObjectMappingInfo alloc] initWithDictionaryKey:dictionaryKey propertyKey:propertyKey andObjectType:nil];
	NSString *key = [self uniqueKeyForClass:class andKey:propertyKey];
	(self.inverseMappingDictionary)[key] = info;
}

- (void)mapFromPropertyKey:(NSString *)propertyKey toDictionaryKey:(NSString *)dictionaryKey forClass:(Class)class withTransformer:(MappingTransformer)transformer {
	ObjectMappingInfo *info = [[ObjectMappingInfo alloc] initWithDictionaryKey:dictionaryKey propertyKey:propertyKey andTransformer:transformer];
	NSString *key = [self uniqueKeyForClass:class andKey:propertyKey];
	(self.inverseMappingDictionary)[key] = info;
}

- (void)excludeMappingForClass:(Class)class withKeys:(NSArray *)keys
{
    (self.excludeKeysDictionary)[NSStringFromClass(class)] = keys;
}

- (void)setDateFormatter:(NSDateFormatter *)dateFormatter forPropertyKey:(NSString *)property andClass:(Class)class
{
	NSString *key = [self uniqueKeyForClass:class andKey:property];
	(self.dateFormatterDictionary)[key] = dateFormatter;
	
	if (self.automaticallyGenerateInverseMapping)
	{
		[self setDateFormatter:dateFormatter forDictionaryKey:property andClass:class];
	}
}

- (void)setDateFormatter:(NSDateFormatter *)dateFormatter forDictionaryKey:(NSString *)dictionaryKey andClass:(Class)class
{
	NSString *key = [self uniqueKeyForClass:class andKey:dictionaryKey];
	(self.inverseDateFormatterDictionary)[key] = dateFormatter;
}

#pragma mark - public Methods -

- (NSString *)uniqueKeyForClass:(Class)class andKey:(NSString *)key
{
	return [NSString stringWithFormat:@"%@-%@", NSStringFromClass(class), key].lowercaseString;
}

#pragma mark - MappingProvider Methods -

- (ObjectMappingInfo *)mappingInfoForClass:(Class)class andDictionaryKey:(NSString *)source
{
	NSString *key = [self uniqueKeyForClass:class andKey:source];
	return (self.mappingDictionary)[key];
}

- (ObjectMappingInfo *)mappingInfoForClass:(Class)class andPropertyKey:(NSString *)source {
	NSString *key = [self uniqueKeyForClass:class andKey:source];
	return (self.inverseMappingDictionary)[key];
}

- (NSDateFormatter *)dateFormatterForClass:(Class)class andPropertyKey:(NSString *)propertyKey
{
	NSString *key = [self uniqueKeyForClass:class andKey:propertyKey];
	return (self.dateFormatterDictionary)[key];
}

- (NSDateFormatter *)dateFormatterForClass:(Class)class andDictionaryKey:(NSString *)dictionaryKey
{
	NSString *key = [self uniqueKeyForClass:class andKey:dictionaryKey];
	return (self.dateFormatterDictionary)[key];
}

- (NSArray *)excludedKeysForClass:(Class)class
{
    return (self.excludeKeysDictionary)[NSStringFromClass(class)];
}

@end
