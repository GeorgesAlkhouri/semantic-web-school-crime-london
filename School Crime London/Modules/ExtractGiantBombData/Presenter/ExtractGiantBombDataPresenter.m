//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ExtractGiantBombDataPresenter.h"
#import "ExtractGiantBombDataWireframe.h"

@interface ExtractGiantBombDataPresenter ()

@end

@implementation ExtractGiantBombDataPresenter

- (void)extractDataWithAPIKey:(NSString *)APIKey {

    [self.interactor startDataExtractionWithGiantBombAPIKey:APIKey];
}

- (void)extractionFinishedWithResults:(NSArray *)results {
}

- (void)errorOccurred:(NSError *)error {

    if (error.code == -1) {

        [self.mainViewDelegate showError:@"Invalid API-Key"];
    } else if (error.code == -2) {

        [self.mainViewDelegate showError:@"Data parsign error"];
    } else {

        [self.mainViewDelegate showError:@"Unknown error occurred"];
    }
}

@end