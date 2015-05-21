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
        
        NSDictionary * csvSet = @{@"Type" : set[1],
                               @"Name" : set[3],
                               @"BuildingName" : set[5],
                               @"BuildingNumber" : set[6],
                               @"Street":set[7],
                               @"Postcode":set[8]};
        
        [csv addObject:csvSet];
    }
    
    return [csv copy];
}

@end