//
// Created by Georges Alkhouri
// Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "TripleStoreQueryInteractor.h"

#import <AFNetworking.h>

@implementation TripleStoreQueryInteractor

- (void)startQueryWithStoreURL:(NSString *)storeURL
                   datasetName:(NSString *)dataset
                       rdfDump:(NSString *)rdfDump {

    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH-mm-ss";

    NSString *formattedDate = [formatter stringFromDate:[NSDate date]];

    NSString *tempFile = [NSTemporaryDirectory()
        stringByAppendingPathComponent:
            [NSString stringWithFormat:@"dump-%@.ttl", formattedDate]];

    NSURL *url = [NSURL fileURLWithPath:tempFile];

    [rdfDump writeToURL:url
             atomically:YES
               encoding:NSUTF8StringEncoding
                  error:nil];

    [self.APIDataManager
        putDumpIntoTripleStoreWithStoreURL:storeURL
                                   fileURL:url
                               datasetName:dataset
                                completion:^(NSError *error) {

                                    if (error) {
                                        [self.presenter errorOccurred:error];
                                    } else {
                                        [self.presenter didPutDumpIntoStore];
                                    }
                                }];
}

- (void)queryForEveryGame:(NSArray *)gameData
                 storeURL:(NSString *)storeURL
              datasetName:(NSString *)dataset {

    NSMutableArray *queries = [NSMutableArray new];

    for (NSDictionary *game in gameData) {

        for (NSInteger i = 1; i <= 6; i++) {

            NSString *query = [self
                createQueryForGame:game[@"GameName"]
                     andMonthStart:[NSString stringWithFormat:@"%d", (int)i - 1]
                       andMonthEnd:[NSString stringWithFormat:@"%d", (int)i]];

            [queries addObject:query];
        }
    }

    [self.APIDataManager queryWithStoreURL:storeURL
        datasetName:dataset
        queries:queries
        progressBlock:^(NSUInteger numberOfFinishedOperations,
                        NSUInteger totalNumberOfOperations) {
            [self.presenter progressUpdated:(double)numberOfFinishedOperations /
                                            totalNumberOfOperations];
        }
        completion:^(NSArray *results) {
            [self processResults:results];
        }];
}

- (void)processResults:(NSArray *)results {

    NSMutableString *result = [NSMutableString new];

    [result appendString:@"monthCount,compareCount,name,"
            @"releaseDate,compareDate,monthStart,monthEnd,"
            @"compareMonthStart,compareMonthEnd \n"];

    for (AFHTTPRequestOperation *operation in results) {

        id responseObject = operation.responseObject;

        if ([responseObject[@"results"][@"bindings"][0][@"monthCount"][@"value"]
                isKindOfClass:[NSNull class]] ||
            [responseObject[@"results"][@"bindings"][0][@"compareCount"][
                @"value"] isKindOfClass:[NSNull class]] ||
            [responseObject[@"results"][@"bindings"][0][@"name"][@"value"]
                isKindOfClass:[NSNull class]] ||
            [responseObject[@"results"][@"bindings"][0][@"releaseDate"][
                @"value"] isKindOfClass:[NSNull class]] ||
            [responseObject[@"results"][@"bindings"][0][@"compareDate"][
                @"value"] isKindOfClass:[NSNull class]] ||
            [responseObject[@"results"][@"bindings"][0][@"monthStart"][@"value"]
                isKindOfClass:[NSNull class]] ||
            [responseObject[@"results"][@"bindings"][0][@"monthEnd"][@"value"]
                isKindOfClass:[NSNull class]] ||
            [responseObject[@"results"][@"bindings"][0][@"compareMonthStart"][
                @"value"] isKindOfClass:[NSNull class]] ||
            [responseObject[@"results"][@"bindings"][0][@"compareMonthEnd"][
                @"value"] isKindOfClass:[NSNull class]]) {

            continue;
        }

        [result appendString:[NSString
                                 stringWithFormat:
                                     @"%@,%@,%@,%@,%@,%@,%@,%@,%@ \n",
                                     responseObject[@"results"][@"bindings"][0][
                                         @"monthCount"][@"value"],
                                     responseObject[@"results"][@"bindings"][0][
                                         @"compareCount"][@"value"],
                                     responseObject[@"results"][@"bindings"][0][
                                         @"name"][@"value"],
                                     responseObject[@"results"][@"bindings"][0][
                                         @"releaseDate"][@"value"],
                                     responseObject[@"results"][@"bindings"][0][
                                         @"compareDate"][@"value"],
                                     responseObject[@"results"][@"bindings"][0][
                                         @"monthStart"][@"value"],
                                     responseObject[@"results"][@"bindings"][0][
                                         @"monthEnd"][@"value"],
                                     responseObject[@"results"][@"bindings"][0][
                                         @"compareMonthStart"][@"value"],
                                     responseObject[@"results"][@"bindings"][0][
                                         @"compareMonthEnd"][@"value"]]];
    }

    [self.presenter didFinishQueryForEveryGameWithCSV:result];
}

// month is a String, 1, 2 ,3 ...
- (NSString *)createQueryForGame:(NSString *)gameName
                   andMonthStart:(NSString *)start
                     andMonthEnd:(NSString *)end {

    NSString *query = [NSString
        stringWithFormat:
            @"PREFIX place: "
            @"<http://www.semanticweb.org/georgesalkhouri/school-crime-london/"
            @"place#> PREFIX location: "
            @"<http://www.semanticweb.org/georgesalkhouri/school-crime-london/"
            @"location#> PREFIX point: "
            @"<http://www.semanticweb.org/georgesalkhouri/school-crime-london/"
            @"point#> PREFIX crime: "
            @"<http://www.semanticweb.org/georgesalkhouri/school-crime-london/"
            @"crime#> PREFIX game: "
            @"<http://www.semanticweb.org/georgesalkhouri/school-crime-london/"
            @"game#> PREFIX school: "
            @"<http://www.semanticweb.org/georgesalkhouri/school-crime-london/"
            @"school#> PREFIX rdf: "
            @"<http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX xsd: "
            @"<http://www.w3.org/2001/XMLSchema#> SELECT ?monthCount "
            @"?compareCount ?name ?releaseDate ?compareDate ?monthStart "
            @"?monthEnd ?compareMonthStart ?compareMonthEnd WHERE { { SELECT "
            @"(COUNT(*) AS ?monthCount) ?releaseDate ?name ?monthStart "
            @"?monthEnd WHERE { { SELECT DISTINCT ?crime ?releaseDate ?name "
            @"?monthStart ?monthEnd WHERE { ?game game:name ?name; "
            @"FILTER(STR(?name) = \"%@\") ?game game:released ?releaseDate . "
            @"BIND (?releaseDate + \"P%@M\"^^xsd:duration AS ?monthEnd) BIND "
            @"(?releaseDate + \"P%@M\"^^xsd:duration AS ?monthStart) ?crime a "
            @"crime:Crime; crime:occurredOn ?crimeDate . Filter (?crimeDate "
            @">= ?monthStart && ?crimeDate <= ?monthEnd) ?crime "
            @"crime:classifiedAs ?category FILTER(STR(?category) = "
            @"\"violent-crime\") } } } GROUP BY ?releaseDate ?name "
            @"?monthStart ?monthEnd } { SELECT (COUNT(*) AS ?compareCount) "
            @"?compareDate (?monthStart AS ?compareMonthStart) (?monthEnd AS "
            @"?compareMonthEnd) WHERE { { SELECT DISTINCT ?crime ?compareDate "
            @"?monthStart ?monthEnd WHERE { ?game game:name ?name; "
            @"FILTER(STR(?name) = \"%@\") ?game game:released ?releaseDate . "
            @"BIND (?releaseDate - \"P1Y\"^^xsd:duration AS ?compareDate) "
            @"BIND (?compareDate + \"P%@M\"^^xsd:duration AS ?monthEnd) BIND "
            @"(?compareDate + \"P%@M\"^^xsd:duration AS ?monthStart) ?crime a "
            @"crime:Crime; crime:occurredOn ?crimeDate . Filter (?crimeDate "
            @">= ?monthStart && ?crimeDate <= ?monthEnd) ?crime "
            @"crime:classifiedAs ?category FILTER(STR(?category) = "
            @"\"violent-crime\") } } } GROUP BY ?compareDate ?monthStart "
            @"?monthEnd } }",
            gameName, end, start, gameName, end, start];

    return query;
}

@end