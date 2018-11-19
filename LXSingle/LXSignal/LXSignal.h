//
//  LXSingle.h
//  LXSingle
//
//  Created by iOS on 2018/11/12.
//  Copyright © 2018 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXSubscriber.h"

typedef void(^SignalBlock)(id<LXSubscriber> subscriber);
typedef void(^NextBlock)(id<LXSubscriber> subscriber, id result);
typedef void(^FinishBlock)(id result);

NS_ASSUME_NONNULL_BEGIN

@interface LXSignal : NSObject <LXSubscriber>

@property (nonatomic,strong) NSString *identifier;

+ (instancetype)createSingle:(SignalBlock)task;

@property (nonatomic,copy) SignalBlock task;

@property (nonatomic,strong) id result;

- (LXSignal *)doNext:(NextBlock)next;

- (void)finish:(FinishBlock)finish;

@end

NS_ASSUME_NONNULL_END
