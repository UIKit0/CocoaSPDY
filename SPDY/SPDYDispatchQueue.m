//
//  SPDYDispatchQueue.m
//  CocoaSPDY
//
//  Created by Blake Watters on 9/10/14.
//  Copyright (c) 2014 Twitter. All rights reserved.
//

#import "SPDYDispatchQueue.h"

static void *SPDYDispatchQueueContextKey = &SPDYDispatchQueueContextKey;

@implementation SPDYDispatchQueue

- (id)init
{
    self = [super init];
    if (self) {
        NSString *queueLabel = [NSString stringWithFormat:@"%@:%p", NSStringFromClass([self class]), self];
        _dispatchQueue = dispatch_queue_create([queueLabel UTF8String], DISPATCH_QUEUE_SERIAL);
        void *nonNullUnusedPointer = (__bridge void *)self;
        dispatch_queue_set_specific(_dispatchQueue, SPDYDispatchQueueContextKey, nonNullUnusedPointer, NULL);
    }
    return self;
}

- (BOOL)isExecutingOnQueue
{
    return dispatch_get_specific(SPDYDispatchQueueContextKey) != NULL;
}

- (void)performBlock:(void (^)(void))block
{
    if (self.isExecutingOnQueue) {
        block();
    } else {
        dispatch_sync(_dispatchQueue, block);
    }
}

- (void)performBlockAndWait:(void (^)(void))block
{
    if (self.isExecutingOnQueue) {
        block();
    } else {
        dispatch_async(_dispatchQueue, block);
    }
}

@end
