//
//  AFHTTPRequestOperation+Additions.m
//  School Crime London
//
//  Created by Georges Alkhouri on 01/06/15.
//  Copyright (c) 2015 Georges Alkhouri. All rights reserved.
//

#import "AFHTTPRequestOperation+Additions.h"
#import <objc/runtime.h>

@implementation AFHTTPRequestOperation (Additions)

- (void)setOriginalData:(NSDictionary *)originalData {

    objc_setAssociatedObject(self, @selector(setOriginalData:), originalData,
                             OBJC_ASSOCIATION_RETAIN);
}

- (NSDictionary *)originalData {

    return objc_getAssociatedObject(self, @selector(setOriginalData:));
}

@end
