//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "SearchCrimeScenePresenter.h"
#import "SearchCrimeSceneWireframe.h"

@implementation SearchCrimeScenePresenter

- (void)requestPoliceDataForGames:(NSArray *)games
                       schoolData:(NSArray *)schoolData {

    [self.mainViewDelegate showInformationText:@"Requesting UK Police."];
}
@end