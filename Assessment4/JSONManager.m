
//
//  JSONManager.m
//  Assessment4
//
//  Created by Mobile Making on 11/13/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "JSONManager.h"

@interface JSONManager ()

@end

@implementation JSONManager

+ (NSArray *)loadJSON
{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"owners"
                                                     ofType:@"json"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSData *data = [NSData dataWithContentsOfURL:url];

    NSArray *owners = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    return owners;
}

@end
