//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ExtractGiantBombDataPresenter.h"
#import "ExtractGiantBombDataWireframe.h"

@interface ExtractGiantBombDataPresenter ()

@end

@implementation ExtractGiantBombDataPresenter

- (void)extractDataWithAPIKey:(NSString *)APIKey userKey:(NSString *)userKey {

    [self.mainViewDelegate
        showInformationText:@"Request Game Information from PEGI"];
    [self.interactor startDataExtractionWithAPIKey:APIKey userKey:userKey];
}

- (void)extractionFinishedWithResults:(NSArray *)results {

    [self.mainViewDelegate extractionDidFinishWithResults:results];
}

- (void)errorOccurred:(NSError *)error {

    if (error.code == -2) {

        [self.mainViewDelegate showError:@"Giant Bomb data parsing error"];
    } else {

        [self.mainViewDelegate showError:error.localizedDescription];
    }
}

@end