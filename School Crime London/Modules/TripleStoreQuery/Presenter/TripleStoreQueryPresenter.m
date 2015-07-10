//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "TripleStoreQueryPresenter.h"
#import "TripleStoreQueryWireframe.h"

#import "MainViewProtocols.h"

@interface TripleStoreQueryPresenter ()

@property(nonatomic) NSArray *gameData;
@property(nonatomic) NSString *dataset;
@property(nonatomic) NSString *storeURL;

@end

@implementation TripleStoreQueryPresenter

- (void)startQueryWithStoreURL:(NSString *)storeURL
                   datasetName:(NSString *)dataset
                       rdfDump:(NSString *)rdfDump
                      gameData:(NSArray *)gameData {

    self.gameData = gameData;
    self.dataset = dataset;
    self.storeURL = storeURL;

    [self.mainViewDelegate
        showInformationText:@"Putting dump file into store."];

    [self.interactor startQueryWithStoreURL:storeURL
                                datasetName:dataset
                                    rdfDump:rdfDump];
}

- (void)progressUpdated:(double)progress {

    [self.mainViewDelegate showProgress:progress];
}

- (void)didPutDumpIntoStore {

    [self.mainViewDelegate showInformationText:@"Start Query..."];

    [self.interactor queryForEveryGame:self.gameData
                              storeURL:self.storeURL
                           datasetName:self.dataset];
}

- (void)didFinishQueryForEveryGameWithCSV:(NSString *)csv {

    [self.mainViewDelegate didReceiveResultFromQuery:csv];
}
- (void)errorOccurred:(NSError *)error {

    [self.mainViewDelegate showError:error.localizedDescription];
}

@end