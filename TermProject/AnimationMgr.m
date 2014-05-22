//
//  AnimationMgr.m
//  TermProject
//
//  Created by LYH on 13. 6. 12..
//
//

#import "AnimationMgr.h"

@implementation AnimationMgr

// 싱글턴이니까
static AnimationMgr *sharedInstance = nil;
+ (AnimationMgr *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            NSLog(@"[SYSTEM] : init AnimationManager");
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}


- (void) LoadData
{
    // 데이터 불러오기 (처음 실행할 때만 호출하면 된다)
    // plist 열고 데이터를 불러오자
	NSString *path = [[NSBundle mainBundle] pathForResource:@"ResourceList_Animation"
                                                     ofType:@"plist"];
    data = [[NSArray alloc] initWithContentsOfFile:path];
}


- (NSInteger) getListSize
{
    return data.count;
}

@end