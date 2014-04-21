	//
//  EZRBaseModelTests.m
//  EasyReader
//
//  Created by Alfredo Uribe on 3/27/14.
//  Copyright (c) 2014 Cloudspace. All rights reserved.
//

#import "EZRBaseModelTests.h"
#import "APIClient.h"
#import "User.h"

@implementation EZRBaseModelTests

- (void)setUp
{
    mockAPIClient = [OCMockObject mockForClass:[APIClient class]];
    mockObserver  = [OCMockObject observerMock];
    
    [APIClient setSharedClient:mockAPIClient];
    
    // Set up core data
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
}


- (void)tearDown
{
    // Clean up core data
    [MagicalRecord cleanUp];
    [User setCurrent:nil];
    [super tearDown];
}

@end
