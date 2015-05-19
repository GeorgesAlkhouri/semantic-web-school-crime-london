//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ParseLondonDataStoreDataInteractor.h"

@implementation ParseLondonDataStoreDataInteractor

- (void)parseData {
    
    NSURL *path = [[NSBundle mainBundle]
        URLForResource:@"london-schools-atlas-processed-data" withExtension:@"csv"];
    
    NSArray * csv = [self.localDataManager parseCSVWithFileURL:path];
    
}

@end