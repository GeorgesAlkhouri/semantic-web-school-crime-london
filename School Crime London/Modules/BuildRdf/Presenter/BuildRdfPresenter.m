//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "BuildRdfPresenter.h"
#import "BuildRdfWireframe.h"

@implementation BuildRdfPresenter

- (void)buildRdfWithSchoolData:(NSArray *)schoolData
                      gameData:(NSArray *)gameData
                     crimeData:(NSArray *)crimeData {

    [self.mainViewDelegate showInformationText:@"Building RDF from Data..."];
    [self.interactor buildRdfWithSchoolData:schoolData
                                   gameData:gameData
                                  crimeData:crimeData];
}

- (void)didBuildRDFDump:(NSString *)rdfDump {

    [self.mainViewDelegate didBuildRDFDumpWithDump:rdfDump];
}

@end