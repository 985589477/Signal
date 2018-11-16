//
//  NSObject+Single.h
//  LXSingle
//
//  Created by iOS on 2018/11/13.
//  Copyright © 2018 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXSignal.h"
#import "LXGroupSubscriber.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Signal)

- (void)singleWithSelector:(NSArray<LXSignal *> *)array target:(id)target notificationSelector:(SEL)selector;

- (void)destructionSignal;
//
@end

NS_ASSUME_NONNULL_END
