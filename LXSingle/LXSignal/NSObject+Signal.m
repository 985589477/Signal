//
//  NSObject+Single.m
//  LXSingle
//
//  Created by iOS on 2018/11/13.
//  Copyright © 2018 Jason. All rights reserved.
//

#import "NSObject+Signal.h"
#import <objc/message.h>
#import "LXSignalGroup.h"

@interface NSObject ()
@property (nonatomic,strong) NSMutableDictionary *signalsDictionary;
@end

@implementation NSObject (Signal)

- (void)singleWithSelector:(NSArray<LXSignal *> *)array target:(id)target notificationSelector:(SEL)selector{
    LXSignalGroup *group = [LXSignalGroup groupWithSingles:array target:target selector:selector];
    [self.signalsDictionary setObject:group forKey:group.identifier];
    [self signalWithGroup:group];
}

- (void)signalWithGroup:(LXSignalGroup *)signalGroup{
    [signalGroup.signalArray enumerateObjectsUsingBlock:^(LXSignal * _Nonnull signal, NSUInteger idx, BOOL * _Nonnull stop) {
        [signal addObserver:signalGroup forKeyPath:@"result" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(self.signalsDictionary)];
        signal.task(signal);
    }];
}

- (void)destructionSignal{
    for (NSString *key in self.signalsDictionary.allKeys) {
        [self.signalsDictionary[key] destructionSignal];
    }
    [self.signalsDictionary removeAllObjects];
}

- (NSMutableDictionary *)signalsDictionary{
    NSMutableDictionary *dictionary = objc_getAssociatedObject(self, @"kSignalsDictionary");
    if (dictionary == nil) {
        dictionary = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @"kSignalsDictionary", dictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dictionary;
}

@end
