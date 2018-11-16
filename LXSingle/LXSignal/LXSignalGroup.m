//
//  LXSingleGroup.m
//  LXSingle
//
//  Created by iOS on 2018/11/15.
//  Copyright © 2018 Jason. All rights reserved.
//

#import "LXSignalGroup.h"

@implementation LXSignalGroup

+ (instancetype)groupWithSingles:(NSArray<LXSignal *> *)signals target:(id)target selector:(SEL)selector{
    LXSignalGroup *group = [[LXSignalGroup alloc] init];
    group.signalArray = signals;
    group.target = target;
    group.selector = selector;
    return group;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _identifier = [self getIdentifier];
    }
    return self;
}

- (void)setSignalArray:(NSArray<LXSignal *> *)signalArray{
    [signalArray enumerateObjectsUsingBlock:^(LXSignal * _Nonnull signal, NSUInteger idx, BOOL * _Nonnull stop) {
        signal.identifier = self.identifier;
    }];
    _signalArray = signalArray;
    _signalCount = signalArray.count;
}

- (NSString *)getIdentifier{
    char data[10];
    for (int x=0;x<10;data[x++] = (char)('A' + (arc4random_uniform(26))));
    NSString *identifier = [[NSString alloc] initWithBytes:data length:10 encoding:NSUTF8StringEncoding];
    return identifier;
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context{
    if ([object isKindOfClass:[LXSignal class]] && [keyPath isEqualToString:@"result"]) {
        NSMutableDictionary *signalsDictionary = (__bridge NSMutableDictionary *)(context);
        LXSignalGroup *signalGroup = [signalsDictionary objectForKey:[(LXSignal *)object identifier]];
        signalGroup.signalCount -= 1;
        if (signalGroup && signalGroup.signalCount == 0) {
            NSMethodSignature *methodSignature = [signalGroup.target methodSignatureForSelector:signalGroup.selector];
            if (methodSignature == nil) {
                NSString *info = [NSString stringWithFormat:@"method( %@ ) is not define", NSStringFromSelector(signalGroup.selector)];
                [NSException raise:@"method crash" format:info, nil];
            }
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
            invocation.selector = signalGroup.selector;
            NSUInteger argsCount = methodSignature.numberOfArguments - 2;
            NSUInteger count = MIN(argsCount, signalGroup.signalArray.count);
            for (int i = 0; i < count; i++) {
                id result = [signalGroup.signalArray[i] result];
                if ([result isKindOfClass:[NSNull class]]) { result = nil; }
                [invocation setArgument:&result atIndex:i + 2];
            }
            [invocation invokeWithTarget:signalGroup.target];
            [signalsDictionary removeObjectForKey:[(LXSignal *)object identifier]];
        }
        [object removeObserver:self forKeyPath:@"result" context:context];
    }
}


@end
