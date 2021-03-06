//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "ExtractGameDataPresenter.h"
#import "ExtractGameDataWireframe.h"

@interface ExtractGameDataPresenter ()

@end

@implementation ExtractGameDataPresenter

- (void)progressUpdated:(double)progress {

    [self.mainViewDelegate showProgress:progress];
}

- (void)extractGameData {

    [self.mainViewDelegate
        showInformationText:@"Request Game Information from PEGI"];
    [self.interactor startDataExtraction];
}

- (void)extractionFinishedWithResults:(NSArray *)results {

    [self.mainViewDelegate extractionDidFinishWithResults:results];
}

- (void)errorOccurred:(NSError *)error {

    if (error.code == -2) {

        [self.mainViewDelegate showError:@"Game data parsing error"];
    } else {

        [self.mainViewDelegate showError:error.localizedDescription];
    }
}

@end