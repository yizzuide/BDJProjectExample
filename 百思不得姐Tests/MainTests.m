//
//  _____Tests.m
//  百思不得姐Tests
//
//  Created by 付星 on 2016/11/17.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BDJRecommendTagInteractor.h"
#import "BDJRecommendTagDataManager.h"
#import "BDJPostService.h"
#import "BDJPostInteractor.h"
#import "BDJPostDataManager.h"

@interface MainTests : XCTestCase

@end

@implementation MainTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

// 异步测试信号数据
- (void)testLoadTagAsync
{
    XCTestExpectation *networkSuccessExpectation = [self expectationWithDescription:@"fetch tags should succeed"];
    BDJRecommendTagInteractor *tagInteractor = [[BDJRecommendTagInteractor alloc] init];
    BDJRecommendTagDataManager *dm = [[BDJRecommendTagDataManager alloc] init];
    [tagInteractor setValue:dm forKeyPath:@"dataManager"];
    [[tagInteractor fetchRecommendTag] subscribeNext:^(id x) {
        NSLog(@"%@",x);
        XCTAssertNotNil(x,@"数据返回失败！");
        // 标注预期达成,触发fulfill方法，跳出单测程序等待状态
        [networkSuccessExpectation fulfill];
    }];
    
    // 等待 3s 期望预期达成
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

// 测试帖子数据的获取
- (void)testPostDict
{
    XCTestExpectation *networkSuccessExpectation = [self expectationWithDescription:@"fetch Posts should succeed"];
    BDJPostService *postService = [[BDJPostService alloc] init];
    [[postService pullPostsForType:BDJPostDataMediaTypeAll] subscribeNext:^(id x) {
        NSLog(@"%@",x);
        XCTAssertNotNil(x,@"数据返回失败！");
        [networkSuccessExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

- (void)testWordsPostRenderData
{
    XCTestExpectation *networkSuccessExpectation = [self expectationWithDescription:@"fetch Posts should succeed"];
    BDJPostInteractor *interactor = [[BDJPostInteractor alloc] init];
    BDJPostDataManager *dataManager = [[BDJPostDataManager alloc] init];
    [interactor setValue:dataManager forKeyPath:@"dataManager"];
    [[interactor fetchPostsForType:BDJPostCategoryTypeWords] subscribeNext:^(id x) {
        NSLog(@"%@",x);
        XCTAssertNotNil(x,@"数据返回失败！");
        [networkSuccessExpectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:3 handler:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
