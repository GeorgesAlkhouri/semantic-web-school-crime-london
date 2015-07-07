//
//  NSString+Additions.h
//  School Crime London
//
//  Created by Georges Alkhouri on 07/06/15.
//  Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (NSString *)urlencode;

+ (NSString *)SHA256StringFromString:(NSString *)string;

@end
