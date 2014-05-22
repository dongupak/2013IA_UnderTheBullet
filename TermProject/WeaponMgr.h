//
//  WeaponMgr.h
//  TermProject
//
//  Created by LYH on 13. 6. 12..
//
//

#import <Foundation/Foundation.h>

@interface WeaponMgr : NSObject
{
    NSArray *data;   // 무기 데이터를 담고 있는 배열
}

// 인스턴스 생성용
+ (WeaponMgr *) sharedInstance;

// 데이터 관련 함수
- (void) LoadData;

// 게임 상에서 사용될 함수
- (NSInteger) getDataCount;

- (NSInteger) getProjectilesPerShoot:(NSInteger)weaponno;
- (NSInteger) getShootsPerAttack:(NSInteger)weaponno;
- (NSInteger) getFramesBetweenShoot:(NSInteger)weaponno;
- (NSInteger) getFramesBetweenAttack:(NSInteger)weaponno;
- (BOOL) getLockOn:(NSInteger)weaponno;
- (NSInteger) getSoundEffect:(NSInteger)weaponno;

- (NSInteger) getProjectileTypeOfWeapon:(NSInteger)weaponno Projectile:(NSInteger)projectileno;
- (NSInteger) getprojectileInitialX:(NSInteger)weaponno Projectile:(NSInteger)projectileno;
- (NSInteger) getprojectileInitialY:(NSInteger)weaponno Projectile:(NSInteger)projectileno;
- (CGFloat) getProjectileAngle:(NSInteger)weaponno Projectile:(NSInteger)projectileno;
- (BOOL) getProjectileAngleChanges:(NSInteger)weaponno Projectile:(NSInteger)projectileno;
- (CGFloat) getProjectileAngleChange:(NSInteger)weaponno Projectile:(NSInteger)projectileno;
- (BOOL) getProjectileDisappears:(NSInteger)weaponno Projectile:(NSInteger)projectileno;
- (NSInteger) getProjectileTTL:(NSInteger)weaponno Projectile:(NSInteger)projectileno;

@end
