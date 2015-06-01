//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "SearchCrimeScenePresenter.h"
#import "SearchCrimeSceneWireframe.h"

@implementation SearchCrimeScenePresenter

- (void)requestPoliceDataForGames:(NSArray *)games
                       schoolData:(NSArray *)schoolData {

    [self.mainViewDelegate
        showInformationText:@"Requesting UK police data store."];
    [self.interactor requestCrimeScenesWithSchoolData:schoolData
                                             gameData:games];
}

- (void)requestFailedWithError:(NSError *)error {

    [self.mainViewDelegate showError:error.localizedDescription];
}

- (void)requestSucceededWithResults:(NSArray *)result {

    [self.mainViewDelegate requestCrimeSceneFinishedWithResults:result];
}

@end