//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "MainViewPresenter.h"
#import "MainViewWireframe.h"

@interface MainViewPresenter ()

@property(nonatomic) NSString *importIOAPIKey;
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

- (void)setImportIOAPIKey:(NSString *)APIKey {

    _importIOAPIKey = APIKey;
}

- (void)setGeofencingAPIKey:(NSString *)APIKey {

    _geofencingAPIKey = APIKey;
}

- (void)setImportIOUserKey:(NSString *)UserKey {

    _importIOUserKey = UserKey;
}

- (void)actionButtonPressed {

    NSArray *schoolData =
        [self.parseLondonDataStoreDataConnection parseLondonDataStoreData:nil];

    [self.translateSchoolNamesToCoordsConnection
        startTranslatingWithAPIKey:self.geofencingAPIKey
                        schoolData:schoolData];
}

- (void)extractionDidFinishWithResults:(NSArray *)results {

    self.gameData = results;

    [self.searchCrimeSceneConnection requestPoliceDataForGames:self.gameData
                                                    schoolData:self.schoolData];
}

- (void)translationDidFinishWithResults:(NSArray *)results {

    self.schoolData = results;

    //    [self.extractGiantBombDataConnection
    //        extractDataWithAPIKey:self.giantBombAPIKey
    //                      userKey:self.importIOUserKey];

    [self.extractGameDataConnection
        extractDataWithAPIKey:@"30a515a1-56e4-4acd-b38c-4d4d49adcb79:1yWjjdf3+"
        @"DQBchLyM616jyR0T5fBzrgeXX9OFEMXGJGw2n8Q3YHRqQ/"
        @"MhrJhENQ+wXwluDkZ8lWT04CpxzXFwQ=="
                      userKey:@"30a515a1-56e4-4acd-b38c-4d4d49adcb79"];
}

- (void)requestCrimeSceneFinishedWithResults:(NSArray *)results {

    self.crimeData = results;

    [self.buildRdfConnection buildRdfWithSchoolData:self.schoolData
                                           gameData:self.gameData
                                          crimeData:self.crimeData];
}

- (void)didBuildRdfWithRdfResults:(NSDictionary *)rdfs {

    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"dd-MM-YY-HH-mm-ss";

    NSString *formattedDate = [formatter stringFromDate:[NSDate date]];

    NSSavePanel *panel = [NSSavePanel savePanel];
    panel.nameFieldStringValue =
        [NSString stringWithFormat:@"SchoolRDF-%@.ttl", formattedDate];

    [panel beginWithCompletionHandler:^(NSInteger result) {

        if (result == NSFileHandlingPanelOKButton) {

            [self writeDictionaryToFilesWithURL:
                      [[panel URL] URLByDeletingLastPathComponent]
                                           rdfs:rdfs
                                      withStamp:formattedDate];
        }

    }];
}

- (void)writeDictionaryToFilesWithURL:(NSURL *)url
                                 rdfs:(NSDictionary *)rdfs
                            withStamp:(NSString *)stamp {

    [rdfs enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *ontology,
                                              BOOL *stop) {

        [ontology writeToURL:[url URLByAppendingPathComponent:
                                      [NSString stringWithFormat:@"%@-%@.ttl",
                                                                 key, stamp]]
                  atomically:YES
                    encoding:NSUTF8StringEncoding
                       error:nil];
    }];
}

@end