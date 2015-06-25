//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "BuildRdfInteractor.h"
#import "NSString+Additions.h"

@implementation BuildRdfInteractor

//"School-Adress" = "Acland Burghley School, 93 Burghley Road, London NW5 1UJ,
// UK";
//"School-Building-Name" = "Acland Burghley School";
//"School-Building-Number" = 93;
//"School-ID" = ChIJ94YBg6obdkgR8kG7ia5Eu0g;
//"School-Lat" = "51.5573286";
//"School-Lng" = "-0.139667";
//"School-Name" = "Acland Burghley School";
//"School-Postcode" = "NW5 1UJ";
//"School-Street" = "Burghley Road";
//"School-Type" = "Secondary school";

//{
//    category = "anti-social-behaviour";
//    context = "";
//    id = 23553943;
//    location =     {
//        latitude = "51.557557";
//        longitude = "-0.138952";
//        street =         {
//            id = 968107;
//            name = "On or near Dartmouth Park Hill";
//        };
//    };
//    "location_subtype" = "";
//    "location_type" = Force;
//    month = "2013-04";
//    "outcome_status" = "<null>";
//    "persistent_id" = "";
//}

//{
//    GameName = "War of the Roses";
//    OriginalGameRating = "Pegi: 18";
//    ReleaseDate = "2013-03-15";
//}

- (void)buildRdfWithSchoolData:(NSArray *)schoolData
                      gameData:(NSArray *)gameData
                     crimeData:(NSArray *)crimeData {

    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-ddTHH:mm:ssZZZZZ";

    NSMutableString *gameOntology =
        [[self loadOntologyWithName:@"game"] mutableCopy];

    for (NSDictionary *game in gameData) {

        NSString *instanceName = [[game[@"GameName"]

            stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]]
            stringByReplacingOccurrencesOfString:@" "
                                      withString:@"-"];

        NSString *rdf =
            [self createGameInstanceWithName:game[@"GameName"]
                                instanceName:instanceName
                                 releaseDate:game[@"ReleaseDate"]
                                      rating:game[@"OriginalGameRating"]];

        [gameOntology appendString:@"\n\n"];
        [gameOntology appendString:rdf];
    }

    NSMutableString *schoolOntology =
        [[self loadOntologyWithName:@"school"] mutableCopy];

    // To prevent duplicate data in ontology, creates IDs for every
    // instance which will be checked before instance is written into
    // ontology.

    NSMutableArray *crimeIDs = [NSMutableArray new];
    NSMutableArray *pointIDs = [NSMutableArray new];
    NSMutableDictionary *schoolIDs = [NSMutableDictionary new];

    for (NSDictionary *crime in crimeData) {

        NSAssert(crime[@"School-ID"] &&
                     ![crime[@"School-ID"] isKindOfClass:[NSNull class]],
                 @"No School-ID");
        NSAssert(crime[@"Crime-ID"] &&
                     ![crime[@"Crime-ID"] isKindOfClass:[NSNull class]],
                 @"No Crime-ID");

        /*** Create Crime RDF ***/

        NSString *crimePointID = [NSString
            SHA512StringFromString:
                [NSString
                    stringWithFormat:@"%@,%@",
                                     crime[@"Crime-Location"][@"Latitude"],
                                     crime[@"Crime-Location"][@"Longitude"]]];
        NSString *crimePointInstanceName =
            [crimePointID stringByAppendingString:@"-Point"];

        // Point can identify location, one point - one location
        NSString *crimeLocationInstanceName =
            [crimePointID stringByAppendingString:@"-Location"];

        if (![pointIDs containsObject:crimePointID]) {

            NSString *pointRDF = [self
                createPointInstaceWithInstaceName:crimePointInstanceName
                                         latitude:crime[@"Crime-Location"][
                                                      @"Latitude"]
                                        longitude:crime[@"Crime-Location"][
                                                      @"Longitude"]];

            [pointIDs addObject:crimePointID];
            [schoolOntology appendString:pointRDF];

            NSString *locationRDF = [self
                createLocationInstaceWithInstanceName:crimeLocationInstanceName
                                               street:nil
                                         streetNumber:nil
                                                 city:nil
                                    pointInstanceName:crimePointInstanceName];

            [schoolOntology appendString:locationRDF];
        }

        NSString *crimeID = crime[@"Crime-ID"];
        NSString *crimeInstanceName =
            [crimeID stringByAppendingString:@"-Crime"];

        if (![crimeIDs containsObject:crimeID]) {

            // TODO: Map category to RDF Instance

            NSString *crimeRDF = [self
                createCrimeInstanceWithInstanceName:crimeInstanceName
                                               name:nil
                                     occurrenceDate:crime[@"Crime-Month"]
                               categoryInstanceName:crime[@"Crime-Category"]
                               locationInstanceName:crimeLocationInstanceName];

            [crimeIDs addObject:crimeID];
            [schoolOntology appendString:crimeRDF];
        }

        /*** Create School RDF ***/

        NSString *schoolPointID = [NSString
            SHA512StringFromString:
                [NSString stringWithFormat:@"%@,%@", crime[@"School-Lat"],
                                           crime[@"School-Lng"]]];
        NSString *schoolPointInstanceName =
            [schoolPointID stringByAppendingString:@"-Point"];

        // Point can identify location, one point - one location
        NSString *schoolLocationInstanceName =
            [schoolPointID stringByAppendingString:@"-Location"];

        if (![pointIDs containsObject:schoolPointID]) {

            NSString *pointRDF =
                [self createPointInstaceWithInstaceName:schoolPointInstanceName
                                               latitude:crime[@"School-Lat"]
                                              longitude:crime[@"School-Lng"]];

            [pointIDs addObject:schoolPointID];
            [schoolOntology appendString:pointRDF];

            NSString *locationRDF = [self
                createLocationInstaceWithInstanceName:schoolLocationInstanceName
                                               street:nil
                                         streetNumber:nil
                                                 city:nil
                                    pointInstanceName:schoolPointInstanceName];

            [schoolOntology appendString:locationRDF];
        }

        NSString *schoolID = crime[@"School-ID"];

        // If school rdf is already created than add new crime to school.
        if (!schoolIDs[schoolID]) {

            NSMutableDictionary *crimesAtSchoolDict = [NSMutableDictionary new];

            NSMutableArray *crimesAtSchool = [NSMutableArray new];
            [crimesAtSchool addObject:crimeInstanceName];

            [crimesAtSchoolDict setObject:crimesAtSchool
                                   forKey:@"crimesAtSchool"];
            [crimesAtSchoolDict setObject:crime[@"School-Name"]
                                   forKey:@"School-Name"];
            [crimesAtSchoolDict setObject:schoolLocationInstanceName
                                   forKey:@"locationInstanceName"];

            [schoolIDs setObject:crimesAtSchoolDict forKey:schoolID];
        } else {

            NSMutableDictionary *crimesAtSchoolDict =
                [schoolIDs[schoolID] mutableCopy];

            NSMutableArray *crimesAtSchool =
                [crimesAtSchoolDict[@"crimesAtSchool"] mutableCopy];
            [crimesAtSchool addObject:crimeInstanceName];

            [crimesAtSchoolDict removeObjectForKey:@"crimesAtSchool"];
            [crimesAtSchoolDict setObject:crimesAtSchool
                                   forKey:@"crimesAtSchool"];

            [schoolIDs removeObjectForKey:schoolID];
            [schoolIDs setObject:crimesAtSchoolDict forKey:schoolID];
        }
    }

    [schoolIDs enumerateKeysAndObjectsUsingBlock:^(NSString *schoolID,
                                                   NSMutableDictionary
                                                       *crimesAtSchoolDict,
                                                   BOOL *stop) {

        NSString *schoolRDF = [self
            createSchoolInstanceWithInstanceName:
                [schoolID stringByAppendingString:@"-School"]
                                            name:crimesAtSchoolDict[
                                                     @"School-Name"]
                            locationInstanceName:crimesAtSchoolDict[
                                                     @"locationInstanceName"]
                              crimeInstanceNames:crimesAtSchoolDict[
                                                     @"crimesAtSchool"]];
        [schoolOntology appendString:schoolRDF];

    }];

    NSString *crimeOntology = [self loadOntologyWithName:@"crime"];
    NSString *locationOntology = [self loadOntologyWithName:@"location"];
    NSString *pointOntology = [self loadOntologyWithName:@"point"];

    [self.presenter didBuildRDFs:@{
        @"CrimeOntology" : crimeOntology,
        @"LocationOntology" : locationOntology,
        @"PointOntology" : pointOntology,
        @"SchoolOntology" : [schoolOntology copy],
        @"GameOntology" : [gameOntology copy]
    }];
}

//@"GameName" : result[@"main"][0],
//@"ReleaseDate" : result[@"main"][1],
//@"OriginalGameRating" : @"Pegi: 18"

- (NSString *)createGameInstanceWithName:(NSString *)name
                            instanceName:(NSString *)instanceName
                             releaseDate:(NSString *)date
                                  rating:(NSString *)rating {

    return
        [NSString stringWithFormat:@":%@ rdf:type :Game , owl:NamedIndividual "
                                   @"; :released \"%@\"^^xsd:dateTime ; :name "
                                   @"\"%@\"^^rdfs:Literal ; :rating \"%@\" .",
                                   instanceName, date, name, rating];
}

- (NSString *)createLocationInstaceWithInstanceName:(NSString *)instanceName
                                             street:(NSString *)street
                                       streetNumber:(NSString *)streetNumber
                                               city:(NSString *)city
                                  pointInstanceName:
                                      (NSString *)pointInstanceName {

    NSMutableString *location = [NSMutableString new];
    [location appendString:[NSString stringWithFormat:@":%@ rdf:type "
                                                      @"location:Location , "
                                                      @"owl:NamedIndividual;",
                                                      instanceName]];
    if (streetNumber)
        [location
            appendString:[NSString stringWithFormat:@"location:streetNumber "
                                                    @"\"%@\"^^rdfs:Literal ;",
                                                    streetNumber]];

    if (street)
        [location
            appendString:
                [NSString
                    stringWithFormat:@"location:street \"%@\"^^rdfs:Literal ;",
                                     street]];

    if (city)
        [location
            appendString:[NSString stringWithFormat:
                                       @"location:city \"%@\"^^rdfs:Literal ;",
                                       city]];

    [location
        appendString:[NSString stringWithFormat:@"location:hasPoint :%@ .",
                                                pointInstanceName]];

    return [location copy];
}

- (NSString *)createPointInstaceWithInstaceName:(NSString *)instanceName
                                       latitude:(NSString *)latitude
                                      longitude:(NSString *)longitude {
    return [NSString stringWithFormat:@":%@ rdf:type point:Point , "
                                      @"owl:NamedIndividual ; point:longitude "
                                      @"\"%@\"^^xsd:double ; point:latitude "
                                      @"\"%@\"^^xsd:double .",
                                      instanceName, longitude, latitude];
}

- (NSString *)
createCrimeInstanceWithInstanceName:(NSString *)instanceName
                               name:(NSString *)name
                     occurrenceDate:(NSString *)occurrenceDate
               categoryInstanceName:(NSString *)categoryInstanceName
               locationInstanceName:(NSString *)locationInstanceName {

    NSMutableString *crime = [NSMutableString new];

    [crime appendString:
               [NSString
                   stringWithFormat:
                       @":%@ rdf:type crime:Crime " @", owl:NamedIndividual ; "
                       @"crime:occurredOn "
                       @"\"%@\"^^xsd:dateTime ; crime:classifiedAs crime:%@ ;",
                       instanceName, occurrenceDate, categoryInstanceName]];

    if (name)
        [crime appendString:[NSString stringWithFormat:
                                          @"place:name \"%@\"^^rdfs:Literal ;",
                                          name]];

    [crime appendString:[NSString stringWithFormat:@"place:isLocatedAt :%@ .",
                                                   locationInstanceName]];

    return [crime copy];
}

- (NSString *)
createSchoolInstanceWithInstanceName:(NSString *)instanceName
                                name:(NSString *)name
                locationInstanceName:(NSString *)locationInstanceName
                  crimeInstanceNames:(NSArray *)crimeInstanceNames {

    NSMutableString *school = [[NSString
        stringWithFormat:@":%@ rdf:type :School , owl:NamedIndividual ; "
                         @"place:name \"%@\"^^rdfs:Literal ;  "
                         @"place:isLocatedAt :%@ ; ",
                         instanceName, name, locationInstanceName] mutableCopy];

    if (crimeInstanceNames.count == 0)
        return [school copy];

    [school appendString:@":nearOf "];

    for (NSInteger i = 0; i < crimeInstanceNames.count; i++) {

        if (i == crimeInstanceNames.count - 1) {

            [school
                appendString:[NSString stringWithFormat:@":%@ .",
                                                        crimeInstanceNames[i]]];
        } else {

            [school
                appendString:[NSString stringWithFormat:@":%@ ,",
                                                        crimeInstanceNames[i]]];
        }
    }

    return [school copy];
}

- (NSString *)loadOntologyWithName:(NSString *)name {

    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"ttl"];
    NSString *ontology = [NSString stringWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];

    return ontology;
}

@end