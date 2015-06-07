//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "MainViewPresenter.h"
#import "MainViewWireframe.h"

@interface MainViewPresenter ()

@property(nonatomic) NSString *giantBombAPIKey;
@property(nonatomic) NSString *importIOUserKey;

@property(nonatomic) NSString *geofencingAPIKey;

@property(nonatomic) NSArray *schoolData;
@property(nonatomic) NSArray *gameData;
@property(nonatomic) NSArray *crimeData;

@end

@implementation MainViewPresenter

- (void)showInformationText:(NSString *)text {

    [self.view setInfoLabelText:text];
}

- (void)showError:(NSString *)errorText {

    [self.view setInfoLabelText:errorText];
}

- (void)setGiantBombAPIKey:(NSString *)APIKey {

    _giantBombAPIKey = APIKey;
}

- (void)setGeofencingAPIKey:(NSString *)APIKey {

    _geofencingAPIKey = APIKey;
}

- (void)setImportIOUserKey:(NSString *)UserKey {

    _importIOUserKey = UserKey;
}

- (void)actionButtonPressed {

    [self.extractGiantBombDataConnection
        extractDataWithAPIKey:@"30a515a1-56e4-4acd-b38c-4d4d49adcb79:1yWjjdf3+"
        @"DQBchLyM616jyR0T5fBzrgeXX9OFEMXGJGw2n8Q3YHRqQ/"
        @"MhrJhENQ+wXwluDkZ8lWT04CpxzXFwQ=="
                      userKey:@"30a515a1-56e4-4acd-b38c-4d4d49adcb79"];

    //    NSArray *schoolData =
    //        [self.parseLondonDataStoreDataConnection
    //        parseLondonDataStoreData:nil];
    //
    //    [self.translateSchoolNamesToCoordsConnection
    //        startTranslatingWithAPIKey:self.geofencingAPIKey
    //                        schoolData:schoolData];
}

- (void)extractionDidFinishWithResults:(NSArray *)results {

    self.gameData = results;

    [self.searchCrimeSceneConnection requestPoliceDataForGames:self.gameData
                                                    schoolData:self.schoolData];
}

- (void)translationDidFinishWithResults:(NSArray *)results {

    self.schoolData = results;

    [self.extractGiantBombDataConnection
        extractDataWithAPIKey:self.giantBombAPIKey
                      userKey:self.importIOUserKey];
}

- (void)requestCrimeSceneFinishedWithResults:(NSArray *)results {

    self.crimeData = results;
}

@end