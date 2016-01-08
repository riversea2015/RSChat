//
//  RSDBManager.h
//  RSChat
//
//  Created by hehai on 1/8/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

#define kDBNAME (@"CMDB.db")

@interface RSDBManager : NSObject {
    @private
    FMDatabase *db;
}

+ (RSDBManager *)sharedManager;

@end
