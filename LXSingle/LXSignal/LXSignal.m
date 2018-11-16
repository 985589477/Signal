//
//  LXSingle.m
//  LXSingle
//
//  Created by iOS on 2018/11/12.
//  Copyright © 2018 Jason. All rights reserved.
//

#import "LXSignal.h"
#import "NSObject+Signal.h"
#import "LXSignalGroup.h"
@implementation LXSignal

+ (LXSignal *)createSingle:(void (^)(id<LXSubscriber> _Nonnull))task{
    LXSignal *single = [LXSignal new];
    single.task = task;
    return single;
}
- (void)sendSingle:(id)result{
    self.result = result;
}


@end
