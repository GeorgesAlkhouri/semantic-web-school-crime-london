//
//  NSDate+Additions.m
//  School Crime London
//
//  Created by Georges Alkhouri on 15/05/15.
//  Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

+ (NSDate *)dateFromFormattedString:(NSString *)formattedString {

    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    NSDate *date = [formatter dateFromString:formattedString];
    return date;
}

@end
