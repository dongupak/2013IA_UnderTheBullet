//
//  ProjectileManager.m
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//
//

#import "ProjectileMgr.h"

@implementation ProjectileMgr

// 싱글턴이니까
static ProjectileMgr *sharedInstance = nil;
+ (ProjectileMgr *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            NSLog(@"[SYSTEM] : init ProjectileManager");
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (void) LoadData
{
    // 데이터 불러오기 (처음 실행할 때만 호출하면 된다)
    // plist 열고 데이터를 불러오자
	NSString *path = [[NSBundle mainBundle] pathForResource:@"PatternList_Projectile"
                                                     ofType:@"plist"];
    data = [[NSArray alloc] initWithContentsOfFile:path];
    NSLog(@"%@",data);
}

- (NSInteger) getDataCount
{
    return data.count;
}

- (NSInteger) getSpriteNo:(NSInteger)projectileno
{
    if (data.count > projectileno)
    {
        NSDictionary *dic = [data objectAtIndex:projectileno];
        return [[dic objectForKey:@"spriteno"] intValue];
    }
    else {return 0;}
}

- (NSInteger) getSpeed:(NSInteger)projectileno
{
    if (data.count > projectileno)
    {
        NSDictionary *dic = [data objectAtIndex:projectileno];
        return [[dic objectForKey:@"speed"] intValue];
    }
    else {return 0;}
}

- (NSInteger) getGuidance:(NSInteger)projectileno
{
    if (data.count > projectileno)
    {
        NSDictionary *dic = [data objectAtIndex:projectileno];
        return [[dic objectForKey:@"guidance"] intValue];
    }
    else {return 0;}
}

- (NSInteger) getBaseDamage:(NSInteger)projectileno
{
    if (data.count > projectileno)
    {
        NSDictionary *dic = [data objectAtIndex:projectileno];
        return [[dic objectForKey:@"basedamage"] intValue];
    }
    else {return 0;}
}

@end
