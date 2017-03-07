//
//  XMLUtil.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/11/9.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "XMLUtil.h"
#import "Coach.h"
#import "Coordinate.h"
#import "Event.h"
#import "EventPlayer.h"
#import "Formation.h"
#import "Leader.h"
#import "MainPlayer.h"
#import "Player.h"
#import "Refree.h"
#import "RootClass.h"
#import "Team.h"

@interface XMLUtil ()<NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser *parse;

@property (nonatomic, copy) NSString *currentElement;

@property (nonatomic, strong) Refree *refree;

@property (nonatomic, strong) Team *team;

@property (nonatomic, strong) Formation *formation;

@property (nonatomic, strong) MainPlayer *mainPlayer;

@property (nonatomic, strong) Coordinate *coordinate;

@property (nonatomic, strong) Leader *leader;

@property (nonatomic, strong) Coach *coach;

@property (nonatomic, strong) Player *player;

@property (nonatomic, strong) Event *event;

@property (nonatomic, strong) EventFormation *eventFormation;

@property (nonatomic, strong) EventPlayer *eventPlayer;

@end

@implementation XMLUtil

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        self.parse = [[NSXMLParser alloc]initWithData:data];
        self.parse.delegate = self;
    }
    return self;
}

- (void)startParse {
    [self.parse parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"start parse");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    self.currentElement = elementName;
    if ([self.currentElement isEqualToString:@"fight"]) {
        self.fight = [[Fight alloc]init];
        self.fight.fightEndTime = attributeDict[@"fightEndTime"];
        self.fight.fightId = attributeDict[@"fightId"];
        self.fight.fightMessage = attributeDict[@"fightMessage"];
        self.fight.fightNumberType = attributeDict[@"fightNumberType"];
        self.fight.fightStartTime = attributeDict[@"fightStartTime"];
        self.fight.fightType = attributeDict[@"fightType"];
        self.fight.fightStatus = attributeDict[@"fightStatus"];
        self.fight.fightPauseTime = attributeDict[@"fightPauseTime"];
        self.fight.fightPauseSpace = attributeDict[@"fightPauseSpace"];
    }else if ([self.currentElement isEqualToString:@"refrees"]){
        
    }else if ([self.currentElement isEqualToString:@"refree"]) {
        self.refree = [[Refree alloc]init];
        self.refree.refreeId = attributeDict[@"refreeId"];
    }else if ([self.currentElement isEqualToString:@"Teams"]) {
        
    }else if ([self.currentElement isEqualToString:@"Team"]) {
        self.team = [[Team alloc]init];
        self.team.isHostTeam = attributeDict[@"isHostTeam"];
        self.team.teamColor = attributeDict[@"teamColor"];
        self.team.teamId = attributeDict[@"teamId"];
        self.team.teamMessage = attributeDict[@"teamMessage"];
    }else if ([self.currentElement isEqualToString:@"formation"]) {
        self.formation = [[Formation alloc]init];
        self.formation.formationId = attributeDict[@"formationId"];
    }else if ([self.currentElement isEqualToString:@"mainPlayer"]) {
        self.mainPlayer = [[MainPlayer alloc]init];
        self.mainPlayer.isCaptain = attributeDict[@"isCaptain"];
        self.mainPlayer.isGoalkeeper = attributeDict[@"isGoalkeeper"];
        self.mainPlayer.isStart = attributeDict[@"isStart"];
        self.mainPlayer.playerId = attributeDict[@"playerId"];
        self.mainPlayer.teamId = attributeDict[@"teamId"];
    }else if ([self.currentElement isEqualToString:@"coordinate"]) {
        self.coordinate = [[Coordinate alloc]init];
    }else if ([self.currentElement isEqualToString:@"leader"]) {
        self.leader = [[Leader alloc]init];
        self.leader.leader = attributeDict[@"leaderId"];
    }else if ([self.currentElement isEqualToString:@"coach"]) {
        self.coach = [[Coach alloc]init];
        self.coach.coachId = attributeDict[@"coachId"];
        self.coach.coachType = attributeDict[@"coachType"];
    }else if ([self.currentElement isEqualToString:@"player"]) {
        self.player = [[Player alloc]init];
        self.player.isCaptain = attributeDict[@"isCaptain"];
        self.player.isGoalkeeper = attributeDict[@"isGoalkeeper"];
        self.player.isStart = attributeDict[@"isStart"];
        self.player.playerId = attributeDict[@"playerId"];
        self.player.teamId = attributeDict[@"teamId"];
    }else if ([self.currentElement isEqualToString:@"event"]) {
        self.event = [[Event alloc]init];
        self.event.eventTypeId = attributeDict[@"eventTypeId"];
        self.event.eventId = attributeDict[@"eventId"];
        self.event.teamId = attributeDict[@"teamId"];
        self.event.eventTeamId = attributeDict[@"eventTeamId"];
    }else if ([self.currentElement isEqualToString:@"eventHostFormation"] || [self.currentElement isEqualToString:@"eventGuestFormation"]) {
        self.eventFormation = [[EventFormation alloc]init];
        self.eventFormation.Id = attributeDict[@"id"];
        self.eventFormation.teamId = attributeDict[@"teamId"];
    }else if ([self.currentElement isEqualToString:@"eventPlayer"]) {
        self.eventPlayer = [[EventPlayer alloc]init];
        self.eventPlayer.isCaptain = attributeDict[@"isCaptain"];
        self.eventPlayer.isGoalkeeper = attributeDict[@"isGoalkeeper"];
        self.eventPlayer.isStart = attributeDict[@"isStart"];
        self.eventPlayer.playerId = attributeDict[@"playerId"];
        self.eventPlayer.teamId = attributeDict[@"teamId"];
    }

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //fight
    if ([self.currentElement isEqualToString:@"fightGround"]) {
        self.fight.fightGround = string;
    }else if ([self.currentElement isEqualToString:@"fightName"]) {
        self.fight.fightName = string;
    }else if ([self.currentElement isEqualToString:@"fightImg"]) {
        self.fight.fightImg = string;
    }else if ([self.currentElement isEqualToString:@"fightVideo"]) {
        self.fight.fightVideo = string;
    }else if ([self.currentElement isEqualToString:@"signImg"]) {
        self.fight.signImg = string;
    } else if ([self.currentElement isEqualToString:@"fightPauseTime"]) {
        self.fight.fightPauseTime = string;
    } else if ([self.currentElement isEqualToString:@"fightPauseSpace"]) {
        self.fight.fightPauseSpace = string;
    }
    
    //refree
    if ([self.currentElement isEqualToString:@"refreeName"]) {
        self.refree.refreeName = string;
    }else if ([self.currentElement isEqualToString:@"refreeImg"]) {
        self.refree.refreeImg = string;
    }
    
    //team
    if ([self.currentElement isEqualToString:@"teamName"]) {
        self.team.teamName = string;
    }else if ([self.currentElement isEqualToString:@"score"]) {
        self.team.score = string;
    }else if ([self.currentElement isEqualToString:@"clothes"]) {
        self.team.clothes = string;
    }else if ([self.currentElement isEqualToString:@"teamRedcard"]) {
        self.team.teamRedcard = string;
    }else if ([self.currentElement isEqualToString:@"teamYellowcard"]) {
        self.team.teamYellowcard = string;
    }else if ([self.currentElement isEqualToString:@"teamSubstitution"]) {
        self.team.teamSubstitution = string;
    }else if ([self.currentElement isEqualToString:@"teamImg"]) {
        self.team.teamImg = string;
    }else if ([self.currentElement isEqualToString:@"teamSignImg"]) {
        self.team.teamSignImg = string;
    }
      //formation
    if ([self.currentElement isEqualToString:@"formationStartTime"]) {
        self.formation.formationStartTime = string;
    }else if ([self.currentElement isEqualToString:@"formationEndTime"]) {
        self.formation.formationEndTime = string;
    }else if ([self.currentElement isEqualToString:@"formationName"]) {
        self.formation.formationName = string;
    }else if ([self.currentElement isEqualToString:@"formationImg"]) {
        self.formation.formationImg = string;
    }
        //mainPlayer
    if (self.mainPlayer) {
        
        if ([self.currentElement isEqualToString:@"playerName"]) {
            self.mainPlayer.playerName = string;
        }else if ([self.currentElement isEqualToString:@"playerImg"]) {
            self.mainPlayer.playerImg = string;
        }else if ([self.currentElement isEqualToString:@"clothesNumber"]) {
            self.mainPlayer.clothesNumber = string;
        }else if ([self.currentElement isEqualToString:@"yellowcard"]) {
            self.mainPlayer.yellowcard = string;
        }else if ([self.currentElement isEqualToString:@"redcard"]) {
            self.mainPlayer.redcard = string;
        }else if ([self.currentElement isEqualToString:@"goldCount"]) {
            self.mainPlayer.goldCount = string;
        }else if ([self.currentElement isEqualToString:@"assistCount"]) {
            self.mainPlayer.assistCount = string;
        }else if ([self.currentElement isEqualToString:@"position"]) {
            self.mainPlayer.position = string;
        }else if ([self.currentElement isEqualToString:@"playeringTime"]) {
            self.mainPlayer.playingTime = string;
        }else if ([self.currentElement isEqualToString:@"saveCount"]) {
            self.mainPlayer.saveCount = string;
        }
    }
    
          //coordinate
    if ([self.currentElement isEqualToString:@"coordinateX"]) {
        self.coordinate.coordinateX = string;
    }else if ([self.currentElement isEqualToString:@"coordinateY"]) {
        self.coordinate.coordinateY = string;
    }else if ([self.currentElement isEqualToString:@"coordinateZ"]) {
        self.coordinate.coordinateZ = string;
    }
    
      //leader
    if ([self.currentElement isEqualToString:@"leaderName"]) {
        self.leader.leaderName = string;
    }else if ([self.currentElement isEqualToString:@"leaderImg"]) {
        self.leader.leaderImg = string;
    }
    
      //coach
    if ([self.currentElement isEqualToString:@"coachName"]) {
        self.coach.coachName = string;
    }else if ([self.currentElement isEqualToString:@"coachImg"]) {
        self.coach.coachImg = string;
    }
    
      //player
    if (self.player) {
        if ([self.currentElement isEqualToString:@"playerName"]) {
            self.player.playerName = string;
        }else if ([self.currentElement isEqualToString:@"playerImg"]) {
            self.player.playerImg = string;
        }else if ([self.currentElement isEqualToString:@"clothesNumber"]) {
            self.player.clothesNumber = string;
        }else if ([self.currentElement isEqualToString:@"yellowcard"]) {
            self.player.yellowcard = string;
        }else if ([self.currentElement isEqualToString:@"redcard"]) {
            self.player.redcard = string;
        }else if ([self.currentElement isEqualToString:@"goldCount"]) {
            self.player.goldCount = string;
        }else if ([self.currentElement isEqualToString:@"assistCount"]) {
            self.player.assistCount = string;
        }else if ([self.currentElement isEqualToString:@"position"]) {
            self.player.position = string;
        }else if ([self.currentElement isEqualToString:@"playeringTime"]) {
            self.player.playingTime = string;
        }else if ([self.currentElement isEqualToString:@"saveCount"]) {
            self.player.saveCount = string;
        }
    }
    
    //event
    if ([self.currentElement isEqualToString:@"eventTypeName"]) {
        self.event.eventTypeName = string;
    }else if ([self.currentElement isEqualToString:@"matchTime"]) {
        self.event.matchTime = string;
    }else if ([self.currentElement isEqualToString:@"eventTime"]) {
        self.event.eventTime = string;
    }else if ([self.currentElement isEqualToString:@"eventMessage"]) {
        self.event.eventMessage = string;
    }else if ([self.currentElement isEqualToString:@"eventImg"]) {
        self.event.eventImg = string;
    }else if ([self.currentElement isEqualToString:@"eventVideo"]) {
        self.event.eventVideo = string;
    }
    
      //eventPlayer
    if (self.eventPlayer) {
        if ([self.currentElement isEqualToString:@"playerName"]) {
            self.eventPlayer.playerName = string;
        }else if ([self.currentElement isEqualToString:@"playerImg"]) {
            self.eventPlayer.playerImg = string;
        }else if ([self.currentElement isEqualToString:@"clothesNumber"]) {
            self.eventPlayer.clothesNumber = string;
        }else if ([self.currentElement isEqualToString:@"yellowcard"]) {
            self.eventPlayer.yellowcard = string;
        }else if ([self.currentElement isEqualToString:@"redcard"]) {
            self.eventPlayer.redcard = string;
        }else if ([self.currentElement isEqualToString:@"goldCount"]) {
            self.eventPlayer.goldCount = string;
        }else if ([self.currentElement isEqualToString:@"assistCount"]) {
            self.eventPlayer.assistCount = string;
        }else if ([self.currentElement isEqualToString:@"position"]) {
            self.eventPlayer.position = string;
        }else if ([self.currentElement isEqualToString:@"playeringTime"]) {
            self.eventPlayer.playingTime = string;
        }else if ([self.currentElement isEqualToString:@"saveCount"]) {
            self.eventPlayer.saveCount = string;
        }
    }
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"fight"]) {
        
    }else if ([elementName isEqualToString:@"refree"]) {
        [self.fight.refrees addObject:self.refree];
        self.refree = nil;
    }else if ([elementName isEqualToString:@"Team"]) {
        [self.fight.teams addObject:self.team];
        self.team = nil;
    }else if ([elementName isEqualToString:@"formation"]) {
        [self.team.formations addObject:self.formation];
        self.formation = nil;
    }else if ([elementName isEqualToString:@"mainPlayer"]) {
        [self.formation.mainPlayers addObject:self.mainPlayer];
        self.mainPlayer = nil;
    }else if ([elementName isEqualToString:@"coordinate"]) {
        if (self.mainPlayer) {
            self.mainPlayer.coordinate = [self.coordinate copy];
        }else if (self.player) {
            self.player.coordinate = [self.coordinate copy];
        }
        self.coordinate = nil;
    }else if ([elementName isEqualToString:@"leader"]) {
        [self.team.leaders addObject:self.leader];
        self.leader = nil;
    }else if ([elementName isEqualToString:@"coach"]) {
        [self.team.coachs addObject:self.coach];
        self.coach = nil;
    }else if ([elementName isEqualToString:@"player"]) {
        [self.team.players addObject:self.player];
        self.player = nil;
    }else if ([elementName isEqualToString:@"eventHostFormation"]) {
        self.event.eventHostFormation = [self.eventFormation copy];
        self.eventFormation = nil;
    }else if ([elementName isEqualToString:@"eventGuestFormation"]) {
        self.event.eventGuestFormation = [self.eventFormation copy];
        self.eventFormation = nil;
    }else if ([elementName isEqualToString:@"eventPlayer"]) {
        [self.event.eventPlayers addObject:self.eventPlayer];
        self.eventPlayer = nil;
    }else if ([elementName isEqualToString:@"event"]) {
        [self.fight.events addObject:self.event];
        self.event = nil;
    }
    self.currentElement = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"%@", @"endParse");
    NSLog(@"%@", self.fight);
    
}

+ (GDataXMLDocument *)xmlFromFight:(Fight *)fight {
    //根节点
    GDataXMLElement *root = [GDataXMLNode elementWithName:@"fight"];
    GDataXMLElement *fightAttri1 = [GDataXMLNode attributeWithName:@"fightEndTime" stringValue:fight.fightEndTime];
    GDataXMLElement *fightAttri2 = [GDataXMLNode attributeWithName:@"fightId" stringValue:fight.fightId];
    GDataXMLElement *fightAttri3 = [GDataXMLNode attributeWithName:@"fightMessage" stringValue:fight.fightMessage];
    GDataXMLElement *fightAttri4 = [GDataXMLNode attributeWithName:@"fightNumberType" stringValue:fight.fightNumberType];
    GDataXMLElement *fightAttri5 = [GDataXMLNode attributeWithName:@"fightStartTime" stringValue:fight.fightStartTime];
    GDataXMLElement *fightAttri6 = [GDataXMLNode attributeWithName:@"fightType" stringValue:fight.fightType];
    GDataXMLElement *fightAttri7 = [GDataXMLNode attributeWithName:@"fightStatus" stringValue:fight.fightStatus];
    GDataXMLElement *fightAttri8 = [GDataXMLNode attributeWithName:@"fightPauseTime" stringValue:fight.fightPauseTime];
    GDataXMLElement *fightAttri9 = [GDataXMLNode attributeWithName:@"fightPauseSpace" stringValue:fight.fightPauseSpace];
    [root addAttribute:fightAttri1];
    [root addAttribute:fightAttri2];
    [root addAttribute:fightAttri3];
    [root addAttribute:fightAttri4];
    [root addAttribute:fightAttri5];
    [root addAttribute:fightAttri6];
    [root addAttribute:fightAttri7];
    [root addAttribute:fightAttri8];
    [root addAttribute:fightAttri9];
    
    GDataXMLElement *fightGround = [GDataXMLNode elementWithName:@"fightGround" stringValue:fight.fightGround];
    GDataXMLElement *fightName = [GDataXMLNode elementWithName:@"fightName" stringValue:fight.fightName];
    GDataXMLElement *fightImg = [GDataXMLNode elementWithName:@"fightImg" stringValue:fight.fightImg];
    GDataXMLElement *fightVideo = [GDataXMLNode elementWithName:@"fightVideo" stringValue:fight.fightVideo];
    GDataXMLElement *signImg = [GDataXMLNode elementWithName:@"signImg" stringValue:fight.signImg];
    
    GDataXMLElement *refrees = [GDataXMLElement elementWithName:@"refrees"];
    GDataXMLElement *teams = [GDataXMLNode elementWithName:@"Teams"];
    GDataXMLElement *events = [GDataXMLNode elementWithName:@"Events"];
    [root addChild:fightGround];
    [root addChild:fightName];
    [root addChild:fightImg];
    [root addChild:fightVideo];
    [root addChild:signImg];
    
    
    //refrees
    for (Refree *r in fight.refrees) {
        GDataXMLElement *refree = [GDataXMLNode elementWithName:@"refree"];
        GDataXMLElement *refreeAttri1 = [GDataXMLNode attributeWithName:@"refreeId" stringValue:r.refreeId];
        [refree addAttribute:refreeAttri1];
        
        GDataXMLElement *refreeName = [GDataXMLNode elementWithName:@"refreeName" stringValue:r.refreeName];
        GDataXMLElement *refreeImg = [GDataXMLNode elementWithName:@"refreeImg" stringValue:r.refreeImg];
        [refree addChild:refreeName];
        [refree addChild:refreeImg];
        [refrees addChild:refree];
    }
    
    //teams
    for (Team *t in fight.teams) {
        GDataXMLElement *team = [GDataXMLNode elementWithName:@"Team"];
        GDataXMLElement *teamAttri1 = [GDataXMLNode attributeWithName:@"isHostTeam" stringValue:t.isHostTeam];
        GDataXMLElement *teamAttri2 = [GDataXMLNode attributeWithName:@"teamColor" stringValue:t.teamColor];
        GDataXMLElement *teamAttri3 = [GDataXMLNode attributeWithName:@"teamId" stringValue:t.teamId];
        GDataXMLElement *teamAttri4 = [GDataXMLNode attributeWithName:@"teamMessage" stringValue:t.teamMessage];
        [team addAttribute:teamAttri1];
        [team addAttribute:teamAttri2];
        [team addAttribute:teamAttri3];
        [team addAttribute:teamAttri4];
        
        GDataXMLElement *teamName = [GDataXMLNode elementWithName:@"teamName" stringValue:t.teamName];
        GDataXMLElement *score = [GDataXMLNode elementWithName:@"score" stringValue:t.score];
        GDataXMLElement *clothes = [GDataXMLNode elementWithName:@"clothes" stringValue:t.clothes];
        GDataXMLElement *redcard = [GDataXMLNode elementWithName:@"teamRedcard" stringValue:t.teamRedcard];
        GDataXMLElement *yellowcard = [GDataXMLNode elementWithName:@"teamYellowcard" stringValue:t.teamYellowcard];
        GDataXMLElement *teamSubstitution = [GDataXMLNode elementWithName:@"teamSubstitution" stringValue:t.teamSubstitution];
        GDataXMLElement *teamImg = [GDataXMLNode elementWithName:@"teamImg" stringValue:t.teamImg];
        GDataXMLElement *teamSignImg = [GDataXMLNode elementWithName:@"teamSignImg" stringValue:t.teamSignImg];
        
        GDataXMLElement *formations = [GDataXMLNode elementWithName:@"formations"];
        GDataXMLElement *leaders = [GDataXMLNode elementWithName:@"leaders"];
        GDataXMLElement *coachs = [GDataXMLNode elementWithName:@"coachs"];
        GDataXMLElement *players = [GDataXMLNode elementWithName:@"players"];
        
        [team addChild:teamName];
        [team addChild:score];
        [team addChild:clothes];
        [team addChild:redcard];
        [team addChild:yellowcard];
        [team addChild:teamSubstitution];
        [team addChild:teamImg];
        [team addChild:teamSignImg];
        
        //leaders
        for (Leader *l in t.leaders) {
            GDataXMLElement *leader = [GDataXMLNode elementWithName:@"leader"];
            GDataXMLElement *leaderAttri1 = [GDataXMLNode attributeWithName:@"leaderId" stringValue:l.leader];
            [leader addAttribute:leaderAttri1];
            
            GDataXMLElement *leaderName = [GDataXMLNode elementWithName:@"leaderName" stringValue:l.leaderName];
            GDataXMLElement *leaderImg = [GDataXMLNode elementWithName:@"leaderImg" stringValue:l.leaderImg];
            [leader addChild:leaderName];
            [leader addChild:leaderImg];
            [leaders addChild:leader];
        }
        
        //coachs
        for (Coach *c in t.coachs) {
            GDataXMLElement *coach = [GDataXMLNode elementWithName:@"coach"];
            GDataXMLElement *coachAttri1 = [GDataXMLNode attributeWithName:@"coachId" stringValue:c.coachId];
            GDataXMLElement *coachAttri2 = [GDataXMLNode attributeWithName:@"coachType" stringValue:c.coachType];
            [coach addAttribute:coachAttri1];
            [coach addAttribute:coachAttri2];
            
            GDataXMLElement *coachName = [GDataXMLNode elementWithName:@"coachName" stringValue:c.coachName];
            GDataXMLElement *coachImg = [GDataXMLNode elementWithName:@"coachImg" stringValue:c.coachImg];
            [coach addChild:coachName];
            [coach addChild:coachImg];
            [coachs addChild:coach];
        }
        
        //players
        for (Player *p in t.players) {
            GDataXMLElement *player = [GDataXMLNode elementWithName:@"player"];
            GDataXMLElement *playerAttri1 = [GDataXMLNode attributeWithName:@"isCaptain" stringValue:p.isCaptain];
            GDataXMLElement *playerAttri2 = [GDataXMLNode attributeWithName:@"isGoalkeeper" stringValue:p.isGoalkeeper];
            GDataXMLElement *playerAttri3 = [GDataXMLNode attributeWithName:@"isStart" stringValue:p.isStart];
            GDataXMLElement *playerAttri4 = [GDataXMLNode attributeWithName:@"playerId" stringValue:p.playerId];
            GDataXMLElement *playerAttri5 = [GDataXMLNode attributeWithName:@"teamId" stringValue:p.teamId];
            [player addAttribute:playerAttri1];
            [player addAttribute:playerAttri2];
            [player addAttribute:playerAttri3];
            [player addAttribute:playerAttri4];
            [player addAttribute:playerAttri5];
            
            GDataXMLElement *playerName = [GDataXMLNode elementWithName:@"playerName" stringValue:p.playerName];
            GDataXMLElement *playerImg = [GDataXMLNode elementWithName:@"playerImg" stringValue:p.playerImg];
            GDataXMLElement *clothesNumber = [GDataXMLNode elementWithName:@"clothesNumber" stringValue:p.clothesNumber];
            GDataXMLElement *yellowcard = [GDataXMLNode elementWithName:@"yellowcard" stringValue:p.yellowcard];
            GDataXMLElement *redcard = [GDataXMLNode elementWithName:@"redcard" stringValue:p.redcard];
            GDataXMLElement *goldCount = [GDataXMLNode elementWithName:@"goldCount" stringValue:p.goldCount];
            GDataXMLElement *assistCount = [GDataXMLNode elementWithName:@"assistCount" stringValue:p.assistCount];
            GDataXMLElement *position = [GDataXMLNode elementWithName:@"position" stringValue:p.position];
            GDataXMLElement *playingTime = [GDataXMLNode elementWithName:@"playingTime" stringValue:p.playingTime];
            GDataXMLElement *saveCount = [GDataXMLNode elementWithName:@"saveCount" stringValue:p.saveCount];
            
            GDataXMLElement *coordinate = [GDataXMLNode elementWithName:@"coordinate"];
            GDataXMLElement *coordinateX = [GDataXMLNode elementWithName:@"coordinateX" stringValue:p.coordinate.coordinateX];
            GDataXMLElement *coordinateY = [GDataXMLNode elementWithName:@"coordinateY" stringValue:p.coordinate.coordinateY];
            GDataXMLElement *coordinateZ = [GDataXMLNode elementWithName:@"coordinateZ" stringValue:p.coordinate.coordinateZ];
            [coordinate addChild:coordinateX];
            [coordinate addChild:coordinateY];
            [coordinate addChild:coordinateZ];
            
            [player addChild:playerName];
            [player addChild:playerImg];
            [player addChild:clothesNumber];
            [player addChild:yellowcard];
            [player addChild:redcard];
            [player addChild:goldCount];
            [player addChild:assistCount];
            [player addChild:position];
            [player addChild:playingTime];
            [player addChild:saveCount];
            [player addChild:coordinate];
            
            [players addChild:player];
        }
        
        [team addChild:formations];
        [team addChild:leaders];
        [team addChild:coachs];
        [team addChild:players];
        [teams addChild:team];
    }
    
    //events
    for (Event *e in fight.events) {
        GDataXMLElement *event = [GDataXMLNode elementWithName:@"event"];
        GDataXMLElement *eventAttri1 = [GDataXMLNode attributeWithName:@"eventTypeId" stringValue:e.eventTypeId];
        GDataXMLElement *eventAttri2 = [GDataXMLNode attributeWithName:@"eventId" stringValue:e.eventId];
        GDataXMLElement *eventAttri3 = [GDataXMLNode attributeWithName:@"teamId" stringValue:e.teamId];
        [event addAttribute:eventAttri1];
        [event addAttribute:eventAttri2];
        [event addAttribute:eventAttri3];
        
        GDataXMLElement *eventTypeName = [GDataXMLNode elementWithName:@"eventTypeName" stringValue:e.eventTypeName];
        GDataXMLElement *matchTime = [GDataXMLNode elementWithName:@"matchTime" stringValue:e.matchTime];
        GDataXMLElement *eventTime = [GDataXMLNode elementWithName:@"eventTime" stringValue:e.eventTime];
        GDataXMLElement *eventMessage = [GDataXMLNode elementWithName:@"eventMessage" stringValue:e.eventMessage];
        GDataXMLElement *eventImg = [GDataXMLNode elementWithName:@"eventImg" stringValue:e.eventImg];
        GDataXMLElement *eventVideo = [GDataXMLNode elementWithName:@"eventVideo" stringValue:e.eventVideo];
        GDataXMLElement *eventHostFormation = [GDataXMLNode elementWithName:@"eventHostFormation"];
        GDataXMLElement *eventHostFormationAttri1 = [GDataXMLNode attributeWithName:@"id" stringValue:e.eventHostFormation.Id];
        GDataXMLElement *eventHostFormationAttri2 = [GDataXMLNode attributeWithName:@"teamId" stringValue:e.eventHostFormation.teamId];
        [eventHostFormation addAttribute:eventHostFormationAttri1];
        [eventHostFormation addAttribute:eventHostFormationAttri2];
        GDataXMLElement *eventGuestFormation = [GDataXMLNode elementWithName:@"eventGuestFormation"];
        GDataXMLElement *eventGuestFormationAttri1 = [GDataXMLNode attributeWithName:@"id" stringValue:e.eventGuestFormation.Id];
        GDataXMLElement *eventGuestFormationAttri2 = [GDataXMLNode attributeWithName:@"teamId" stringValue:e.eventGuestFormation.teamId];
        [eventGuestFormation addAttribute:eventGuestFormationAttri1];
        [eventGuestFormation addAttribute:eventGuestFormationAttri2];
        GDataXMLElement *eventPlayers = [GDataXMLNode elementWithName:@"eventPlayers"];
        [event addChild:eventTypeName];
        [event addChild:eventTime];
        [event addChild:matchTime];
        [event addChild:eventMessage];
        [event addChild:eventImg];
        [event addChild:eventVideo];
        [event addChild:eventHostFormation];
        [event addChild:eventGuestFormation];
        
        
        for (EventPlayer *ep in e.eventPlayers) {
            GDataXMLElement *eventPlayer = [GDataXMLNode elementWithName:@"eventPlayer"];
            GDataXMLElement *playerAttri1 = [GDataXMLNode attributeWithName:@"isCaptain" stringValue:ep.isCaptain];
            GDataXMLElement *playerAttri2 = [GDataXMLNode attributeWithName:@"isGoalkeeper" stringValue:ep.isGoalkeeper];
            GDataXMLElement *playerAttri3 = [GDataXMLNode attributeWithName:@"isStart" stringValue:ep.isStart];
            GDataXMLElement *playerAttri4 = [GDataXMLNode attributeWithName:@"playerId" stringValue:ep.playerId];
            GDataXMLElement *playerAttri5 = [GDataXMLNode attributeWithName:@"teamId" stringValue:ep.teamId];
            [eventPlayer addAttribute:playerAttri1];
            [eventPlayer addAttribute:playerAttri2];
            [eventPlayer addAttribute:playerAttri3];
            [eventPlayer addAttribute:playerAttri4];
            [eventPlayer addAttribute:playerAttri5];
            
            GDataXMLElement *playerName = [GDataXMLNode elementWithName:@"playerName" stringValue:ep.playerName];
            GDataXMLElement *playerImg = [GDataXMLNode elementWithName:@"playerImg" stringValue:ep.playerImg];
            GDataXMLElement *clothesNumber = [GDataXMLNode elementWithName:@"clothesNumber" stringValue:ep.clothesNumber];
            GDataXMLElement *yellowcard = [GDataXMLNode elementWithName:@"yellowcard" stringValue:ep.yellowcard];
            GDataXMLElement *redcard = [GDataXMLNode elementWithName:@"redcard" stringValue:ep.redcard];
            GDataXMLElement *goldCount = [GDataXMLNode elementWithName:@"goldCount" stringValue:ep.goldCount];
            GDataXMLElement *assistCount = [GDataXMLNode elementWithName:@"assistCount" stringValue:ep.assistCount];
            GDataXMLElement *position = [GDataXMLNode elementWithName:@"position" stringValue:ep.position];
            GDataXMLElement *playingTime = [GDataXMLNode elementWithName:@"playingTime" stringValue:ep.playingTime];
            GDataXMLElement *saveCount = [GDataXMLNode elementWithName:@"saveCount" stringValue:ep.saveCount];
            
            GDataXMLElement *coordinate = [GDataXMLNode elementWithName:@"coordinate"];
            GDataXMLElement *coordinateX = [GDataXMLNode elementWithName:@"coordinateX" stringValue:ep.coordinate.coordinateX];
            GDataXMLElement *coordinateY = [GDataXMLNode elementWithName:@"coordinateY" stringValue:ep.coordinate.coordinateY];
            GDataXMLElement *coordinateZ = [GDataXMLNode elementWithName:@"coordinateZ" stringValue:ep.coordinate.coordinateZ];
            [coordinate addChild:coordinateX];
            [coordinate addChild:coordinateY];
            [coordinate addChild:coordinateZ];
            
            [eventPlayer addChild:playerName];
            [eventPlayer addChild:playerImg];
            [eventPlayer addChild:clothesNumber];
            [eventPlayer addChild:yellowcard];
            [eventPlayer addChild:redcard];
            [eventPlayer addChild:goldCount];
            [eventPlayer addChild:assistCount];
            [eventPlayer addChild:position];
            [eventPlayer addChild:playingTime];
            [eventPlayer addChild:saveCount];
            [eventPlayer addChild:coordinate];
            
            [eventPlayers addChild:eventPlayer];
        }
        [event addChild:eventPlayers];
        
        [events addChild:event];
    }
    
    [root addChild:refrees];
    [root addChild:teams];
    [root addChild:events];
    
    
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc]initWithRootElement:root];

    [xmlDoc setCharacterEncoding:@"UTF-8"];
    [xmlDoc setVersion:@"1.0"];

    NSData *data = [xmlDoc XMLData];
    [data writeToFile:getFightFilePath() atomically:YES];
    
    NSString *xmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", xmlString);
    return xmlDoc;
    
}

//获取存贮log的位置
NSString *getFightFilePath(){
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return filePath;
}


@end
