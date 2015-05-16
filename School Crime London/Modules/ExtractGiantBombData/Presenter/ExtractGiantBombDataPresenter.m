//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ExtractGiantBombDataPresenter.h"
#import "ExtractGiantBombDataWireframe.h"

@interface ExtractGiantBombDataPresenter ()

@property(nonatomic) NSString *giantBombAPIKey;

@end

@implementation ExtractGiantBombDataPresenter

- (void)setGiantBombAPIKey:(NSString *)APIKey {

    _giantBombAPIKey = APIKey;
}

- (void)errorOccurred:(NSError *)error {

    if (error.code == -1) {

        [self.view setInfoLabelText:@"Invalid API-Key"];
    } else if (error.code == -2) {

        [self.view setInfoLabelText:@"Data parsign error"];
    } else {

        [self.view setInfoLabelText:@"Unknown error occurred"];
    }
}

- (void)actionButtonPressed {

    [self.view setInfoLabelText:@"Loading game data..."];
    [self.interactor
        startDataExtractionWithGiantBombAPIKey:self.giantBombAPIKey];
}

@end