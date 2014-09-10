//
//  SPDYDispatchQueue.h
//  CocoaSPDY
//
//  Created by Blake Watters on 9/10/14.
//  Copyright (c) 2014 Twitter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPDYDispatchQueue : NSObject

@property (nonatomic, readonly) dispatch_queue_t dispatchQueue;
@property (nonatomic, readonly) BOOL isExecutingOnQueue;

- (void)performBlock:(void (^)(void))block;
- (void)performBlockAndWait:(void (^)(void))block;

@end
