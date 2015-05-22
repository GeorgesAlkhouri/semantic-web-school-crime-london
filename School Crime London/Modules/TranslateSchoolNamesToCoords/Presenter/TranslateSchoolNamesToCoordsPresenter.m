//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "TranslateSchoolNamesToCoordsPresenter.h"
#import "TranslateSchoolNamesToCoordsWireframe.h"

@implementation TranslateSchoolNamesToCoordsPresenter

- (void)startTranslatingWithAPIKey:(NSString *)APIKey
                        schoolData:(NSArray *)schoolData {

    [self.mainViewDelegate
        showInformationText:@"Translating school names to geo coordinates."];
    [self.interactor startTranslatingWithAPIKey:APIKey schoolData:schoolData];
}

- (void)translationDidFinishedWithError:(NSError *)error {

    if (error.code == -2) {

        [self.mainViewDelegate showError:@"GeoCoding parsing error."];
    } else {

        [self.mainViewDelegate showError:error.localizedDescription];
    }
}

- (void)translationDidFinishedWithResults:(NSArray *)results {

    [self.mainViewDelegate translationDidFinishWithResults:results];
}

@end