//
//  LXSubscriber.h
//  LXSingle
//
//  Created by iOS on 2018/11/13.
//  Copyright © 2018 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LXSubscriber <NSObject>

- (void)sendSingle:(id)result;

@end

