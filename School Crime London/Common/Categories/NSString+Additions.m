//
//  NSString+Additions.m
//  School Crime London
//
//  Created by Georges Alkhouri on 07/06/15.
//  Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "NSString+Additions.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (Additions)

- (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' ') {
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' ||
                   thisChar == '~' || (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+ (NSString *)SHA256StringFromString:(NSString *)string {

    const char *s = [string cStringUsingEncoding:NSUTF8StringEncoding];

    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};

    CC_SHA256(keyData.bytes, (int)keyData.length, digest);

    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];

    return [[[[out description] stringByReplacingOccurrencesOfString:@"<"
                                                          withString:@""]
        stringByReplacingOccurrencesOfString:@">"
                                  withString:@""]
        stringByReplacingOccurrencesOfString:@" "
                                  withString:@""];
}

@end
