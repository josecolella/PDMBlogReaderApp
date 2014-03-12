//
//  BlogReader.m
//  PropertyExample
//
//  Created by Jose Colella on 10/03/2014.
//  Copyright (c) 2014 Jose Colella. All rights reserved.
//

#import "BlogReader.h"
#import "HTMLNode.h"
#import "HTMLParser.h"



@implementation BlogReader


#pragma mark - Designated Initilizers

- (id) initWithUrl:(NSString *)blogSpotURL {
    self = [super init];
    
    if (self) {
        NSError *error = nil;
        self.blogURL = [NSURL URLWithString:blogSpotURL];
        self.blogPostURLArray = [NSMutableArray array];
        self.blogPostTitleArray = [NSMutableArray array];
        self.blogIconArray = [NSMutableArray array];
        
        HTMLParser *parser = [[HTMLParser alloc] initWithContentsOfURL:self.blogURL error:&error];
        
        HTMLNode *bodyNode = [parser body];
        NSArray *urlNodeArray = [bodyNode findChildrenOfClass:@"blog-title"];
        NSArray *postNodeArray = [bodyNode findChildrenOfClass:@"item-title"];
        NSArray *iconNodeArray = [bodyNode findChildrenOfClass:@"blog-icon"];
        
        //For the blog url
        for (HTMLNode * blog in urlNodeArray) {
            NSArray * children = [blog children];
            for (HTMLNode * child in children) {
                if ([child getAttributeNamed:@"href"] != nil) {
                    [self.blogPostURLArray addObject:[child getAttributeNamed:@"href"]];
                    
                }
            }
        }
      
        for (HTMLNode * blogPost in postNodeArray) {
            NSArray * children = [blogPost children];
            for (HTMLNode * child in children) {
                if ([[child tagName] isEqualToString:@"a"]) {
                    NSString * cleanContent = [[child contents] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                    [self.blogPostTitleArray addObject:cleanContent];
                }
            }
        }
        
        if([self.blogPostTitleArray count] < [self.blogPostURLArray count]) {
            while ([self.blogPostTitleArray count] < [self.blogPostURLArray count]) {
                [self.blogPostTitleArray addObject:@"[ERROR NO HAY ENTRADA DE BLOG]"];
            }
        }
        
        
        //For the blog icon
        for (HTMLNode * blogIcon in iconNodeArray) {
            NSArray * children = [blogIcon children];
            for (HTMLNode *child in children) {
                if ([child getAttributeNamed:@"data-lateloadsrc"] != nil) {
                    NSString * imageUrlString = [child getAttributeNamed:@"data-lateloadsrc"];
                    [self.blogIconArray addObject:[NSURL URLWithString:imageUrlString]];
                }
            }
        }
        
        
    }
    return self;
}

#pragma mark - Convenience Constructor

+ (id) blogReader {
    return [[self alloc] init];
}


+ (id) blogReaderWithUrl: (NSString *)blogSpotURL {
    return [[self alloc] initWithUrl:blogSpotURL];
}



#pragma mark - Methods

- (NSUInteger) size {
    
    
    NSUInteger size = [self.blogPostURLArray count];
    return size;
}

- (id) urltAtIndex: (NSUInteger) index {
    return [self.blogPostURLArray objectAtIndex:index];
}

- (id) postAtIndex: (NSUInteger) index {
    return [self.blogPostTitleArray objectAtIndex:index];
}
- (id) iconAtIndex: (NSUInteger)index {
    return [self.blogIconArray objectAtIndex:index];
}

- (void)saveToPlist {
    
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
    NSArray * peopleName = @[@"Jose", @"Maria"];
    NSArray * peopleNumber = @[@"858-453-6212", @"619-987-6071"];
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:
                               [NSArray arrayWithObjects: peopleName, peopleNumber, nil]
                                                          forKeys:[NSArray arrayWithObjects: @"Names", @"Phones", nil]];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    }
    else {
        NSLog(@"%@",error);

    }
    

}
@end
