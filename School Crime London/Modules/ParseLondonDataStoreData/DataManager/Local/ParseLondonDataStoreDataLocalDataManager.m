//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <CHCSVParser.h>

#import "ParseLondonDataStoreDataLocalDataManager.h"

@implementation ParseLondonDataStoreDataLocalDataManager

- (NSArray *)parseCSVWithFileURL:(NSURL *)path {

    NSArray *temp = [NSArray arrayWithContentsOfCSVURL:path];
    NSMutableArray *csv = [NSMutableArray new];
    
    for (NSArray * set in temp) {
        
        NSString * csvString = set[0];
        NSArray * csvSet = [csvString componentsSeparatedByString:@";"];
        
        [csv addObject:csvSet];
    }
    
    return [csv copy];
}

@end