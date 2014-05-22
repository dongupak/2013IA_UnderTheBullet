//
//  EnemyManager.m
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//
//

#import "EnemyMgr.h"

@implementation EnemyMgr

// 싱글턴이니까
static EnemyMgr *sharedInstance = nil;
+ (EnemyMgr *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            NSLog(@"[SYSTEM] : init EnemyManager");
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (void) LoadData
{
    {
        // 데이터 불러오기 (처음 실행할 때만 호출하면 된다)
        // plist 열고 데이터를 불러오자
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PatternList_Enemy"
                                                         ofType:@"plist"];
        data = [[NSArray alloc] initWithContentsOfFile:path];
    }
}

- (NSInteger) getDataCount
{
    return data.count;
}


- (NSInteger) getSpriteNo:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"spriteno"] intValue];
    }
    else {return 0;}
}

- (NSInteger) getBaseScore:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"basescore"] intValue];
    }
    else {return 0;}
}

- (NSInteger) getMovementType:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"moementtype"] intValue];
    }
    else {return 0;}
}
- (NSInteger) getMovementLevel:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"movementlevel"] intValue];
    }
    else {return 0;}
}
- (NSInteger) getSpeed:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"speed"] intValue];
    }
    else {return 0;}
}

- (NSInteger) getTimeForWaiting:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"timeforwaiting"] intValue];
    }
    else {return 0;}
}

- (BOOL) getIsIndestructable:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"isindestructable"] boolValue];
    }
    else {return 0;}
}
- (NSInteger) getMaxHP:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"maxHP"] intValue];
    }
    else {return 0;}
}
- (NSInteger) getStrikeZoneX:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"strikezoneX"] intValue];
    }
    else {return 0;}
}
- (NSInteger) getStrikeZoneY:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"strikezoneY"] intValue];
    }
    else {return 0;}
}
- (NSInteger) getStrikeZoneW:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"strikezoneW"] intValue];
    }
    else {return 0;}
}
- (NSInteger) getStrikeZoneH:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"stirkezoneH"] intValue];
    }
    else {return 0;}
}

- (NSInteger) getWeaponNo:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"weaponno"] intValue];
    }
    else {return 0;}
}

- (BOOL) getIsEscapes:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"isescapes"] boolValue];
    }
    else {return 0;}
}
- (NSInteger) getDestination2:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"destination2"] intValue];
    }
    else {return 0;}
}

- (BOOL) getIsDisappears:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"isdisappears"] boolValue];
    }
    else {return 0;}
}
- (NSInteger) getTimeToLive:(NSInteger)enemyno
{
    if (data.count > enemyno)
    {
        NSDictionary *dic = [data objectAtIndex:enemyno];
        return [[dic objectForKey:@"timetolive"] intValue];
    }
    else {return 0;}
}

@end
