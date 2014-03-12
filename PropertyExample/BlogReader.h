//
//  BlogReader.h
//  PropertyExample
//
//  Created by Jose Colella on 10/03/2014.
//  Copyright (c) 2014 Jose Colella. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BlogReader : NSObject
@property (nonatomic, strong) NSURL * blogURL;
@property (nonatomic, strong) NSMutableArray * blogPostTitleArray;
@property (nonatomic, strong) NSMutableArray * blogPostURLArray;
@property (nonatomic, strong) NSMutableArray * blogIconArray;



#pragma mark - Designated Initilizers

- (id) initWithUrl: (NSString *)blogSpotURL;

#pragma mark - Convenience Constructor

+ (id) blogReader;
+ (id) blogReaderWithUrl: (NSString *)blogSpotURL;


#pragma mark - Methods

- (id) urltAtIndex: (NSUInteger) index;
- (id) postAtIndex: (NSUInteger) index;
- (id) iconAtIndex: (NSUInteger) index;
- (NSUInteger) size;
- (void) saveToPlist;
@end
