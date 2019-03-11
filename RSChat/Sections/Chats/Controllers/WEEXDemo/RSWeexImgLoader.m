//
//  RSWeexImgLoader.m
//  RSChat
//
//  Created by hehai on 2019/3/11.
//  Copyright © 2019 hehai. All rights reserved.
//

#import "RSWeexImgLoader.h"
#import <AFNetworking/AFNetworking.h>

@interface RSWeexImgLoader ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation RSWeexImgLoader

- (id<WXImageOperationProtocol>)downloadImageWithURL:(NSString *)url imageFrame:(CGRect)imageFrame userInfo:(NSDictionary *)options completed:(void(^)(UIImage *image,  NSError *error, BOOL finished))completedBlock {
    
    self.dataTask = [self.sessionManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *imageData = responseObject;
        UIImage *image = [UIImage imageWithData:imageData];
        completedBlock(image,nil,YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completedBlock(nil,error,YES);
    }];
    return self;
}

- (void)cancel {
    [self.dataTask cancel];
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _sessionManager;
}

@end
