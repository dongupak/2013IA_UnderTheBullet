//
//  SoundMgr.m
//  TermProject
//
//  Created by LYH on 13. 6. 12..
//
//

#import "SoundMgr.h"


@implementation SoundMgr

// 싱글턴이니까
static SoundMgr *sharedInstance = nil;
+ (SoundMgr *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            NSLog(@"[SYSTEM] : init SoundManager");
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}


- (void) LoadData
{
    // 데이터 불러오기 (처음 실행할 때만 호출하면 된다)
    // plist 열고 데이터를 불러오자
	NSString *path = [[NSBundle mainBundle] pathForResource:@"ResourceList_Sound"
                                                     ofType:@"plist"];
    data = [[NSArray alloc] initWithContentsOfFile:path];
    
    // SAE 초기화
    sae = [SimpleAudioEngine sharedEngine];
    // 효과음을 미리 로딩해놓는다
    for (int i = 0; i < data.count; i++)
        [sae preloadEffect:[data objectAtIndex:i]];
 }


- (NSInteger) getListSize
{
    return data.count;
}

- (void) playSound:(NSInteger)soundno
{
    [sae playEffect:[data objectAtIndex:soundno]];
}

@end
