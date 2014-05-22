//
//  SpriteMgr.m
//  TermProject
//
//  Created by LYH on 13. 6. 12..
//
//

#import "SpriteMgr.h"

@implementation SpriteMgr

// 싱글턴이니까
static SpriteMgr *sharedInstance = nil;
+ (SpriteMgr *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            NSLog(@"[SYSTEM] : init SpriteManager");
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}


- (void) LoadData
{
    // 데이터 불러오기 (처음 실행할 때만 호출하면 된다)
    // plist 열고 데이터를 불러오자
	NSString *path = [[NSBundle mainBundle] pathForResource:@"ResourceList_Sprite"
                                                     ofType:@"plist"];
    data = [[NSArray alloc] initWithContentsOfFile:path];
}


- (NSInteger) getListSize
{
    return data.count;
}

- (NSString*) getSpritePath:(NSInteger)spriteno
{
    if (data.count > spriteno)
    {
        return [data objectAtIndex:spriteno];
    }
    else {return nil;}
}

@end
