//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ParseLondonDataStoreDataInteractor.h"

@implementation ParseLondonDataStoreDataInteractor

- (NSArray *)parseData {

    NSURL *path = [[NSBundle mainBundle] URLForResource:@"LBCSchool-processed"
                                          withExtension:@"csv"];

    NSArray *csv = [self.localDataManager parseCSVWithFileURL:path];
    return [self processResults:csv];
}

// Keys
// "Type"
// "Name"
// "BuildingName"
// "BuildingNumber"
// "Street"
// "Postcode"
- (NSArray *)processResults:(NSArray *)results {

    NSMutableArray *relevantCsv = [NSMutableArray new];

    for (NSDictionary *csvSet in results) {

        if ([csvSet[@"Type"] isEqualToString:@"Secondary school"] ||
            [csvSet[@"Name"] containsString:@"College"]) {

            [relevantCsv addObject:csvSet];
        }
    }
    
    return [relevantCsv copy];
}

@end