//
//  ItemManager.m
//  TermProject
//
//  Created by LYH on 13. 5. 22..
//
//

#import "ItemMgr.h"

@implementation ItemMgr

// 싱글턴이니까
static ItemMgr *sharedInstance = nil;
+ (ItemMgr *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            NSLog(@"[SYSTEM] : init ItemManager");
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (void) LoadData
{
    // 데이터 불러오기 (처음 실행할 때만 호출하면 된다)
    // plist 열고 데이터를 불러오자
	NSString *path = [[NSBundle mainBundle] pathForResource:@"PatternList_Item"
                                                     ofType:@"plist"];
    data = [[NSArray alloc] initWithContentsOfFile:path];
}
- (NSInteger) getDataCount
{
    return data.count;
}

- (NSInteger) getSpriteNo:(NSInteger)value
{
    return 0;
}

@end