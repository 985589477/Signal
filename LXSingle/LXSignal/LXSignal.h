//
//  LXSingle.h
//  LXSingle
//
//  Created by iOS on 2018/11/12.
//  Copyright © 2018 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXSubscriber.h"
NS_ASSUME_NONNULL_BEGIN

@interface LXSignal : NSObject <LXSubscriber>

@property (nonatomic,strong) NSString *identifier;

+ (LXSignal *)createSingle:(void(^)(id<LXSubscriber> subscriber))task;

@property (nonatomic,copy) void(^task)(id<LXSubscriber> subscriber);

@property (nonatomic,strong) id result;

@end

NS_ASSUME_NONNULL_END
