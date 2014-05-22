//
//  WeaponMgr.m
//  TermProject
//
//  Created by LYH on 13. 6. 12..
//
//

#import "WeaponMgr.h"


@implementation WeaponMgr

// 싱글턴이니까
static WeaponMgr *sharedInstance = nil;
+ (WeaponMgr *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            NSLog(@"[SYSTEM] : init WeaponManager");
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (void) LoadData
{
    // 데이터 불러오기 (처음 실행할 때만 호출하면 된다)
    // plist 열고 데이터를 불러오자
	NSString *path = [[NSBundle mainBundle] pathForResource:@"PatternList_Weapon"
                                                     ofType:@"plist"];
    data = [[NSArray alloc] initWithContentsOfFile:path];
}

- (NSInteger) getDataCount
{
    return data.count;
}

- (NSInteger) getProjectilesPerShoot:(NSInteger)weaponno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        return [[dic objectForKey:@"projectilespershoot"] intValue];
    }
    else {return 0;}
}
- (NSInteger) getShootsPerAttack:(NSInteger)weaponno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        return [[dic objectForKey:@"shootsperattack"] intValue];
    }
    else {return 0;}
}
- (NSInteger) getFramesBetweenShoot:(NSInteger)weaponno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        return [[dic objectForKey:@"framesbetweenshoot"] intValue];
    }
    else {return 0;}
}
- (NSInteger) getFramesBetweenAttack:(NSInteger)weaponno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        return [[dic objectForKey:@"framesbetweenattack"] intValue];
    }
    else {return 0;}
}
- (BOOL) getLockOn:(NSInteger)weaponno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        return [[dic objectForKey:@"lockon"] boolValue];
    }
    else {return 0;}
}
- (NSInteger) getSoundEffect:(NSInteger)weaponno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        return [[dic objectForKey:@"soundeffect"] intValue];
    }
    else {return 0;}
}


- (NSInteger) getProjectileTypeOfWeapon:(NSInteger)weaponno Projectile:(NSInteger)projectileno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        NSArray *arr = [dic objectForKey:@"projectiles"];
        if (arr.count > projectileno)
        {
            NSDictionary *projectiledata = [arr objectAtIndex:projectileno];
            return [[projectiledata objectForKey:@"projectiletype"] intValue];
        }
        else {return 0;}
    }
    else {return 0;}
}
- (NSInteger) getprojectileInitialX:(NSInteger)weaponno Projectile:(NSInteger)projectileno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        NSArray *arr = [dic objectForKey:@"projectiles"];
        if (arr.count > projectileno)
        {
            NSDictionary *projectiledata = [arr objectAtIndex:projectileno];
            return [[projectiledata objectForKey:@"projectileinitialX"] intValue];
        }
        else {return 0;}
    }
    else {return 0;}
}
- (NSInteger) getprojectileInitialY:(NSInteger)weaponno Projectile:(NSInteger)projectileno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        NSArray *arr = [dic objectForKey:@"projectiles"];
        if (arr.count > projectileno)
        {
            NSDictionary *projectiledata = [arr objectAtIndex:projectileno];
            return [[projectiledata objectForKey:@"projectileinitialY"] intValue];
        }
        else {return 0;}
    }
    else {return 0;}
}
- (CGFloat) getProjectileAngle:(NSInteger)weaponno Projectile:(NSInteger)projectileno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        NSArray *arr = [dic objectForKey:@"projectiles"];
        if (arr.count > projectileno)
        {
            NSDictionary *projectiledata = [arr objectAtIndex:projectileno];
            return [[projectiledata objectForKey:@"projectileangle"] floatValue];
        }
        else {return 0;}
    }
    else {return 0;}
}
- (BOOL) getProjectileAngleChanges:(NSInteger)weaponno Projectile:(NSInteger)projectileno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        NSArray *arr = [dic objectForKey:@"projectiles"];
        if (arr.count > projectileno)
        {
            NSDictionary *projectiledata = [arr objectAtIndex:projectileno];
            return [[projectiledata objectForKey:@"projectileanglechanges"] boolValue];
        }
        else {return 0;}
    }
    else {return 0;}
}
- (CGFloat) getProjectileAngleChange:(NSInteger)weaponno Projectile:(NSInteger)projectileno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        NSArray *arr = [dic objectForKey:@"projectiles"];
        if (arr.count > projectileno)
        {
            NSDictionary *projectiledata = [arr objectAtIndex:projectileno];
            return [[projectiledata objectForKey:@"projectileanglechange"] floatValue];
        }
        else {return 0;}
    }
    else {return 0;}
}
- (BOOL) getProjectileDisappears:(NSInteger)weaponno Projectile:(NSInteger)projectileno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        NSArray *arr = [dic objectForKey:@"projectiles"];
        if (arr.count > projectileno)
        {
            NSDictionary *projectiledata = [arr objectAtIndex:projectileno];
            return [[projectiledata objectForKey:@"projectiledisappears"] boolValue];
        }
        else {return 0;}
    }
    else {return 0;}
}
- (NSInteger) getProjectileTTL:(NSInteger)weaponno Projectile:(NSInteger)projectileno
{
    if (data.count > weaponno)
    {
        NSDictionary *dic = [data objectAtIndex:weaponno];
        NSArray *arr = [dic objectForKey:@"projectiles"];
        if (arr.count > projectileno)
        {
            NSDictionary *projectiledata = [arr objectAtIndex:projectileno];
            return [[projectiledata objectForKey:@"projectileTTL"] intValue];
        }
        else {return 0;}
    }
    else {return 0;}
}

@end
