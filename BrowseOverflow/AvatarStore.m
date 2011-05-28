//
//  AvatarStore.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "AvatarStore.h"
#import "GravatarCommunicator.h"

@implementation AvatarStore

- (id)init {
    self = [super init];
    if (self) {
        dataCache = [[NSMutableDictionary alloc] init];
        communicators = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [dataCache release];
    [communicators release];
    [super dealloc];
}

- (NSData *)dataForURL:(NSURL *)url {
    NSData *avatarData = [dataCache objectForKey: [url absoluteString]];
    if (!avatarData) {
        GravatarCommunicator *communicator = [[GravatarCommunicator alloc] init];
        [communicators setObject: communicator forKey: [url absoluteString]];
        communicator.delegate = self;
        [communicator fetchDataForURL: url];
        [communicator release];
    }
    return avatarData;
}

- (void)didReceiveMemoryWarning: (NSNotification *)note {
    [dataCache removeAllObjects];
}

- (void)registerForMemoryWarnings:(NSNotificationCenter *)center {
    [center addObserver: self selector: @selector(didReceiveMemoryWarning:) name: UIApplicationDidReceiveMemoryWarningNotification object: nil];
}

- (void)removeRegistrationForMemoryWarnings:(NSNotificationCenter *)center {
    [center removeObserver: self];
}

- (void)communicatorGotErrorForURL:(NSURL *)url {
    
}

- (void)communicatorReceivedData:(NSData *)data forURL:(NSURL *)url {
    
}
@end
