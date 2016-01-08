//
//  RSFileTools.m
//  RSChat
//
//  Created by hehai on 1/8/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import "RSFileTools.h"

@implementation RSFileTools

+ (NSString *)getDocPath
{
    NSArray *docArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [docArr objectAtIndex:0];
}

@end
