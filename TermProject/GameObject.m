//
//  GameObject.m
//  TermProject
//
//  Created by LYH on 13. 5. 20..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject

@synthesize iscollided, isremoved, objectcategory, objecttype;
@synthesize isinvisible, isinvincible, effectactiavated, effectno, effectremaining;
@synthesize isshooting, weaponno, shootcount, framestonextshot, framestonextattack;
@synthesize isindestructable, maxHP, currentHP, strikezoneX, strikezoneY, strikezoneW, strikezoneH;
@synthesize speed, movementX, movementY, angle, angledifference;
@synthesize movementtype, movementlevel, targettype, guidance;
@synthesize isescapes, destinationX, destinationY, timeforwaiting, destination2;
@synthesize isdisappears, timetolive;

@end
