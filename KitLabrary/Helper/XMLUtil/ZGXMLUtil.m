//
//  ZGXMLUtil.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/12/6.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "ZGXMLUtil.h"
#import "XMLDictionary.h"
#import "XmlPackage.h"
#import "XmlResolve2.h"
#import "RuntimeUtil.h"

extern NSString * getFightFilePath();

@implementation ZGXMLUtil

+ (FightModel *)fightFromXMLData:(NSData *)xmlData {
    
//    NSDictionary *dic = [[XMLDictionaryParser sharedInstance] dictionaryWithData:xmlData];
    
    
    NSError *err = nil;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:&err];
    GDataXMLElement *rootElement = [doc rootElement];
    return [self parseFight:rootElement];
}

+ (FightModel *) parseFight:(GDataXMLElement *)rootElement {
    FightModel *fight = [[FightModel alloc]init];
    fight._fixtureId = [[[rootElement elementsForName:@"_fixtureId"] objectAtIndex:0] stringValue];
    fight._usePlayerRecords = [[[rootElement elementsForName:@"_usePlayerRecords"] objectAtIndex:0] stringValue];
    //解析nonpr_team_player
    NSArray *nonpr_team_playerArray = [rootElement elementsForName:@"nonpr_team_player"];
    fight.nonpr_team_playerArray = [self parse_nonpr_team_playerArray:nonpr_team_playerArray];
    
    for (Nonpr_team_player *p in fight.nonpr_team_playerArray) {
        [fight.fightCommonInfo.nonpr_team_playerDic setObject:p forKey:p._nonprPlayerId];
    }
    
    //解析player_position
    NSArray *player_positionArray = [rootElement elementsForName:@"player_position"];
    fight.player_positionArray = [self parse_player_positionArray:player_positionArray];
    
    for (Player_position *p in fight.player_positionArray) {
        [fight.fightCommonInfo.player_positionDic setObject:p forKey:p._playerPositionId];
    }
    
    //解析pr_activity
    NSArray *pr_activityArray = [rootElement elementsForName:@"pr_activity"];
    fight.pr_activityArray = [self parse_pr_activityArray:pr_activityArray];
    
    for (Pr_activity *p in fight.pr_activityArray) {
        [fight.fightCommonInfo.pr_activityDic setObject:p forKey:p._activityCode];
    }
    
    //解析pr_minutes
    NSArray *pr_minutesArray = [rootElement elementsForName:@"pr_minutes"];
    fight.pr_minutesArray = [self parse_pr_minutesArray:pr_minutesArray];
    
    //解析pr_player
    NSArray *pr_playerArray = [rootElement elementsForName:@"pr_player"];
    fight.pr_playerArray = [self parse_pr_playerArray:pr_playerArray];
    
    for (Pr_player *p in fight.pr_playerArray) {
        [fight.fightCommonInfo.pr_playerDic setObject:p forKey:p._prPlayerId];
    }
    
    //解析pr_squad
    NSArray *pr_squadArray = [rootElement elementsForName:@"pr_squad"];
    fight.pr_squadArray = [self parse_pr_squadArray:pr_squadArray];
    
    for (Pr_squad *p in fight.pr_squadArray) {
        [fight.fightCommonInfo.pr_squadDic setObject:p forKey:p._squadId];
    }
    
    //解析pr_team_player
    NSArray *pr_team_playerArray = [rootElement elementsForName:@"pr_team_player"];
    fight.pr_team_playerArray = [self parse_pr_team_playerArray:pr_team_playerArray];
    
    for (Pr_team_player *p in fight.pr_team_playerArray) {
        [fight.fightCommonInfo.pr_team_playerDic setObject:p forKey:p._prPlayerId];
    }
    
    //解析session
    NSArray *sessionArray = [rootElement elementsForName:@"session"];
    fight.session = [self parse_session:sessionArray];
    
    for (Screen_player *player in [[fight.session.screenArray lastObject] playerArray]) {
        if (![fight.fightCommonInfo.pr_playerDic objectForKey:[player _teamPlayerId]]) {
            Nonpr_team_player *p = [fight.fightCommonInfo.nonpr_team_playerDic objectForKey:[player _teamPlayerId]];
            if ([p._teamSide isEqualToString:@"Opposition"]) {
                [fight.fightCommonInfo.guestOnFieldPlayerArray addObject:[player _teamPlayerId]];
            }else {
                [fight.fightCommonInfo.hostOnFieldPlayerArray addObject:[player _teamPlayerId]];
            }
        }else {
            [fight.fightCommonInfo.hostOnFieldPlayerArray addObject:[player _teamPlayerId]];
        }
    }
    
    //解析video
    NSArray *videoArray = [rootElement elementsForName:@"video"];
    fight.videoArray = [self parse_videoArray:videoArray];
    
    return fight;
}

//解析nonpr_team_player
+ (NSMutableArray<Nonpr_team_player *> *) parse_nonpr_team_playerArray:(NSArray *)nonpr_team_playerArray{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *nonpr_team_player in nonpr_team_playerArray) {
        Nonpr_team_player *player = [[Nonpr_team_player alloc]init];
        player._familyName = [[[nonpr_team_player elementsForName:@"_familyName"] objectAtIndex:0] stringValue];
        player._givenName = [[[nonpr_team_player elementsForName:@"_givenName"] objectAtIndex:0] stringValue];
        player._nonprPlayerId = [[[nonpr_team_player elementsForName:@"_nonprPlayerId"] objectAtIndex:0] stringValue];
        player._playerNumber = [[[nonpr_team_player elementsForName:@"_playerNumber"] objectAtIndex:0] stringValue];
        player._playerPositionId = [[[nonpr_team_player elementsForName:@"_playerPositionId"] objectAtIndex:0] stringValue];
        player._poseId = [[[nonpr_team_player elementsForName:@"_poseId"] objectAtIndex:0] stringValue];
        player._sortOrder = [[[nonpr_team_player elementsForName:@"_sortOrder"] objectAtIndex:0] stringValue];
        player._teamSide = [[[nonpr_team_player elementsForName:@"_teamSide"] objectAtIndex:0] stringValue];
        [arr addObject:player];
    }
    return arr;
}

//解析player_positionArray
+ (NSMutableArray<Player_position *> *) parse_player_positionArray:(NSArray *)player_positionArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *player_position in player_positionArray) {
        Player_position *playerPosition = [[Player_position alloc] init];
        playerPosition._isGoalkeeper = [[[player_position elementsForName:@"_isGoalkeeper"] objectAtIndex:0] stringValue];
        playerPosition._playerPositionId = [[[player_position elementsForName:@"_playerPositionId"] objectAtIndex:0] stringValue];
        playerPosition._playerPositionName = [[[player_position elementsForName:@"_playerPositionName"] objectAtIndex:0] stringValue];
        [arr addObject:playerPosition];
    }
    return arr;
}

//解析pr_activity
+ (NSMutableArray<Pr_activity *> *) parse_pr_activityArray:(NSArray *)pr_activityArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *pr_activity in pr_activityArray) {
        Pr_activity *activity = [[Pr_activity alloc]init];
        activity._activityCode = [[[pr_activity elementsForName:@"_activityCode"] objectAtIndex:0] stringValue];
        activity._activityId = [[[pr_activity elementsForName:@"_activityId"] objectAtIndex:0] stringValue];
        activity._activityName = [[[pr_activity elementsForName:@"_activityName"] objectAtIndex:0] stringValue];
        [arr addObject:activity];
    }
    return arr;
}

//解析pr_minutes
+ (NSMutableArray<Pr_minutes *> *)parse_pr_minutesArray:(NSArray *)pr_minutesArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *pr_minutes in pr_minutesArray) {
        Pr_minutes *minutes = [[Pr_minutes alloc]init];
        minutes._activityCode = [[[pr_minutes elementsForName:@"_activityCode"] objectAtIndex:0] stringValue];
        minutes._comment = [[[pr_minutes elementsForName:@"_comment"] objectAtIndex:0] stringValue];
        minutes._offset = [[[pr_minutes elementsForName:@"_offset"] objectAtIndex:0] stringValue];
        minutes._screenId = [[[pr_minutes elementsForName:@"_screenId"] objectAtIndex:0] stringValue];
        minutes._playerId = [[[pr_minutes elementsForName:@"_teamPlayerId"] objectAtIndex:0] stringValue];
        minutes._time = [[[pr_minutes elementsForName:@"_time"] objectAtIndex:0] stringValue];
        [arr addObject:minutes];
    }
    return arr;
}

//解析pr_player
+ (NSMutableArray<Pr_player *> *)parse_pr_playerArray:(NSArray *)pr_playerArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *pr_player in pr_playerArray) {
        Pr_player *player = [[Pr_player alloc]init];
        player._familyName = [[[pr_player elementsForName:@"_familyName"] objectAtIndex:0] stringValue];
        player._givenName = [[[pr_player elementsForName:@"_givenName"] objectAtIndex:0] stringValue];
        player._prPlayerId = [[[pr_player elementsForName:@"_prPlayerId"] objectAtIndex:0] stringValue];
        [arr addObject:player];
    }
    return arr;
}

//解析pr_squad
+ (NSMutableArray<Pr_squad *> *)parse_pr_squadArray:(NSArray *)pr_squadArray{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *pr_squad in pr_squadArray) {
        Pr_squad *squad = [[Pr_squad alloc]init];
        squad._coachSquad = [[[pr_squad elementsForName:@"_coachSquad"] objectAtIndex:0] stringValue];
        squad._squadId = [[[pr_squad elementsForName:@"_squadId"] objectAtIndex:0] stringValue];
        squad._squadName = [[[pr_squad elementsForName:@"_squadName"] objectAtIndex:0] stringValue];
        [arr addObject:squad];
    }
    return arr;
}

//解析pr_team_player
+ (NSMutableArray<Pr_team_player *> *)parse_pr_team_playerArray:(NSArray *)pr_team_playerArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *pr_team_player in pr_team_playerArray) {
        
        Pr_team_player *player = [[Pr_team_player alloc]init];
        player._lastTeam = [[[pr_team_player elementsForName:@"_lastTeam"] objectAtIndex:0] stringValue];
        player._playerNumber = [[[pr_team_player elementsForName:@"_playerNumber"] objectAtIndex:0] stringValue];
        player._playerPositionId = [[[pr_team_player elementsForName:@"_playerPositionId"] objectAtIndex:0] stringValue];
        player._poseId = [[[pr_team_player elementsForName:@"_poseId"] objectAtIndex:0] stringValue];
        player._prPlayerId = [[[pr_team_player elementsForName:@"_prPlayerId"] objectAtIndex:0] stringValue];
        player._sortOrder = [[[pr_team_player elementsForName:@"_sortOrder"] objectAtIndex:0] stringValue];
        player._squadId = [[[pr_team_player elementsForName:@"_squadId"] objectAtIndex:0] stringValue];
        player._squadMember = [[[pr_team_player elementsForName:@"_squadMember"] objectAtIndex:0] stringValue];
        [arr addObject:player];
    }
    
    return arr;
}

//解析session
+ (Session *)parse_session:(NSArray *)sessionArray {
    Session *session = [[Session alloc] init];
    GDataXMLElement *sessionE = [sessionArray firstObject];
    session._globalFlipH = [[[sessionE elementsForName:@"_globalFlipH"] objectAtIndex:0] stringValue];
    session._globalSspToolVersion = [[[sessionE elementsForName:@"_globalSspToolVersion"] objectAtIndex:0] stringValue];
    session._interfaceBaseUrl = [[[sessionE elementsForName:@"_interfaceBaseUrl"] objectAtIndex:0] stringValue];
    session._interfaceLanguageCode = [[[sessionE elementsForName:@"_interfaceLanguageCode"] objectAtIndex:0] stringValue];
    session._itemBaseUrl = [[[sessionE elementsForName:@"_itemBaseUrl"] objectAtIndex:0] stringValue];
    session._matchMinutes = [[[sessionE elementsForName:@"_matchMinutes"] objectAtIndex:0] stringValue];
    session._matchScoreOpposition = [[[sessionE elementsForName:@"_matchScoreOpposition"] objectAtIndex:0] stringValue];
    session._matchScoreUs = [[[sessionE elementsForName:@"_matchScoreUs"] objectAtIndex:0] stringValue];
    session._maxScreens = [[[sessionE elementsForName:@"_maxScreens"] objectAtIndex:0] stringValue];
    session._screenTeamFlip = [[[sessionE elementsForName:@"_screenTeamFlip"] objectAtIndex:0] stringValue];
    session._sessionCategoryId = [[[sessionE elementsForName:@"_sessionCategoryId"] objectAtIndex:0] stringValue];
    session._sessionDifficultyLevelId = [[[sessionE elementsForName:@"_sessionDifficultyLevelId"] objectAtIndex:0] stringValue];
    session._sessionLanguageCode = [[[sessionE elementsForName:@"_sessionLanguageCode"] objectAtIndex:0] stringValue];
    session._sessionOverallDescription = [[[sessionE elementsForName:@"_sessionOverallDescription"] objectAtIndex:0] stringValue];
    session._sessionSkillLevelId = [[[sessionE elementsForName:@"_sessionSkillLevelId"] objectAtIndex:0] stringValue];
    session._sessionSport = [[[sessionE elementsForName:@"_sessionSport"] objectAtIndex:0] stringValue];
    session._sessionStartTime = [[[sessionE elementsForName:@"_sessionStartTime"] objectAtIndex:0] stringValue];
    session._sessionTitle = [[[sessionE elementsForName:@"_sessionTitle"] objectAtIndex:0] stringValue];
    session._sessionToken = [[[sessionE elementsForName:@"_sessionToken"] objectAtIndex:0] stringValue];
    session._sessionType = [[[sessionE elementsForName:@"_sessionType"] objectAtIndex:0] stringValue];
    session._sessionUseSkillLevel = [[[sessionE elementsForName:@"_sessionUseSkillLevel"] objectAtIndex:0] stringValue];
    session._teamNameOpposition = [[[sessionE elementsForName:@"_teamNameOpposition"] objectAtIndex:0] stringValue];
    session._teamNameOurs = [[[sessionE elementsForName:@"_teamNameOurs"] objectAtIndex:0] stringValue];
    session._teamPlayerNameFormat = [[[sessionE elementsForName:@"_teamPlayerNameFormat"] objectAtIndex:0] stringValue];
    session._teamPlayerNumberFormat = [[[sessionE elementsForName:@"_teamPlayerNumberFormat"] objectAtIndex:0] stringValue];
    session._teamPlayerPositionDisplay = [[[sessionE elementsForName:@"_teamPlayerPositionDisplay"] objectAtIndex:0] stringValue];
    session._teamPlayersPerTeam = [[[sessionE elementsForName:@"_teamPlayersPerTeam"] objectAtIndex:0] stringValue];
    session._teamWePlay = [[[sessionE elementsForName:@"_teamWePlay"] objectAtIndex:0] stringValue];
    session._userImageBase = [[[sessionE elementsForName:@"_userImageBase"] objectAtIndex:0] stringValue];
    session._uuid = [[[sessionE elementsForName:@"_uuid"] objectAtIndex:0] stringValue];
    session._xmlMySessionsRedirect = [[[sessionE elementsForName:@"_xmlMySessionsRedirect"] objectAtIndex:0] stringValue];
    session._xmlReceiveBase = [[[sessionE elementsForName:@"_xmlReceiveBase"] objectAtIndex:0] stringValue];
    session._xmlSendBase = [[[sessionE elementsForName:@"_xmlSendBase"] objectAtIndex:0] stringValue];
    session._xmlTeamBase = [[[sessionE elementsForName:@"_xmlTeamBase"] objectAtIndex:0] stringValue];
    session.YioksOurTeamLeaderName = [[[sessionE elementsForName:@"YioksOurTeamLeaderName"] objectAtIndex:0] stringValue];
    session.YioksOurTeamLeaderSign = [[[sessionE elementsForName:@"YioksOurTeamLeaderSign"] objectAtIndex:0] stringValue];
    session.YioksOppositionTeamLeaderName = [[[sessionE elementsForName:@"YioksOppositionTeamLeaderName"] objectAtIndex:0] stringValue];
    session.YioksOppositionTeamLeaderSign = [[[sessionE elementsForName:@"YioksOppositionTeamLeaderSign"] objectAtIndex:0] stringValue];
    session.YioksRefreeName = [[[sessionE elementsForName:@"YioksRefreeName"] objectAtIndex:0] stringValue];
    session.YioksRefreeSign = [[[sessionE elementsForName:@"YioksRefreeSign"] objectAtIndex:0] stringValue];
    
    //解析session - kit
    NSArray *kitArray = [sessionE elementsForName:@"kit"];
    session.kitArray = [self parse_sessionKitArray:kitArray];
    
    //解析lines_library
    NSArray *lines_libraryArray = [sessionE elementsForName:@"lines_library"];
    session.lines_libraryArray = [self parse_session_lines_libraryArray:lines_libraryArray];
    
    //解析link_item
    NSArray *link_itemArray = [sessionE elementsForName:@"link_item"];
    session.link_itemArray = [self parse_session_link_itemArray:link_itemArray];
    
    //解析screen
    NSArray *screenArray = [sessionE elementsForName:@"screen"];
    session.screenArray = [self parse_session_screenArray:screenArray];
    
    //解析screen_default
    NSArray *screen_defaultArray = [sessionE elementsForName:@"screen_defaults"];
    session.screen_defaultArray = [self parse_session_screen_defaultArray:screen_defaultArray];
    
    
    return session;
}

//解析session - kit
+ (NSMutableArray<Kit *> *)parse_sessionKitArray:(NSArray *)kitArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *kit in kitArray) {
        Kit *k = [[Kit alloc]init];
        k._bottomColor = [[[kit elementsForName:@"_bottomColor"] objectAtIndex:0] stringValue];
        k._hairColor = [[[kit elementsForName:@"_hairColor"] objectAtIndex:0] stringValue];
        k._hairType = [[[kit elementsForName:@"_hairType"] objectAtIndex:0] stringValue];
        k._kitId = [[[kit elementsForName:@"_kitId"] objectAtIndex:0] stringValue];
        k._kitTypeId = [[[kit elementsForName:@"_kitTypeId"] objectAtIndex:0] stringValue];
        k._shoesColor = [[[kit elementsForName:@"_shoesColor"] objectAtIndex:0] stringValue];
        k._skinColor = [[[kit elementsForName:@"_skinColor"] objectAtIndex:0] stringValue];
        k._skinTexture = [[[kit elementsForName:@"_skinTexture"] objectAtIndex:0] stringValue];
        k._socksColor = [[[kit elementsForName:@"_socksColor"] objectAtIndex:0] stringValue];
        k._stripesColor = [[[kit elementsForName:@"_stripesColor"] objectAtIndex:0] stringValue];
        k._stripesType = [[[kit elementsForName:@"_stripesType"] objectAtIndex:0] stringValue];
        k._topColor = [[[kit elementsForName:@"_topColor"] objectAtIndex:0] stringValue];
        [arr addObject:k];
    }
    return arr;
}

//解析lines_library
+ (NSMutableArray<Lines_library *> *)parse_session_lines_libraryArray:(NSArray *)lines_libraryArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *lines_library in lines_libraryArray) {
        Lines_library *l = [[Lines_library alloc]init];
        l._arrowThickness = [[[lines_library elementsForName:@"_arrowThickness"] objectAtIndex:0] stringValue];
        l._lineColor = [[[lines_library elementsForName:@"_lineColor"] objectAtIndex:0] stringValue];
        l._lineStyle = [[[lines_library elementsForName:@"_lineStyle"] objectAtIndex:0] stringValue];
        l._lineThickness = [[[lines_library elementsForName:@"_lineThickness"] objectAtIndex:0] stringValue];
        l._lineType = [[[lines_library elementsForName:@"_lineType"] objectAtIndex:0] stringValue];
        l._linesLibraryId = [[[lines_library elementsForName:@"_linesLibraryId"] objectAtIndex:0] stringValue];
        l._useArrowHead = [[[lines_library elementsForName:@"_useArrowHead"] objectAtIndex:0] stringValue];
        l._useHandles = [[[lines_library elementsForName:@"_useHandles"] objectAtIndex:0] stringValue];
        [arr addObject:l];
    }
    return arr;
}

//解析link_item
+ (NSMutableArray<Link_item *> *)parse_session_link_itemArray:(NSArray *)link_itemArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *link_item in link_itemArray) {
        Link_item *link = [[Link_item alloc] init];
        link._itemCode = [[[link_item elementsForName:@"_itemCode"] objectAtIndex:0] stringValue];
        link._itemLocation = [[[link_item elementsForName:@"_itemLocation"] objectAtIndex:0] stringValue];
        [arr addObject:link];
    }
    return arr;
}

//解析screen
+ (NSMutableArray<Screen *> *) parse_session_screenArray:(NSArray *)screenArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *screen in screenArray) {
        Screen *s = [[Screen alloc]init];
        s._cameraFOV = [[[screen elementsForName:@"_cameraFOV"] objectAtIndex:0] stringValue];
        s._cameraPanAngle = [[[screen elementsForName:@"_cameraPanAngle"] objectAtIndex:0] stringValue];
        s._cameraTarget = [[[screen elementsForName:@"_cameraTarget"] objectAtIndex:0] stringValue];
        s._cameraTiltAngle = [[[screen elementsForName:@"_cameraTiltAngle"] objectAtIndex:0] stringValue];
        s._cameraType = [[[screen elementsForName:@"_cameraType"] objectAtIndex:0] stringValue];
        s._cameraZoom = [[[screen elementsForName:@"_cameraZoom"] objectAtIndex:0] stringValue];
        s._dbTransitionId = [[[screen elementsForName:@"_dbTransitionId"] objectAtIndex:0] stringValue];
        s._globalObjScale = [[[screen elementsForName:@"_globalObjScale"] objectAtIndex:0] stringValue];
        s._globalRotationY = [[[screen elementsForName:@"_globalRotationY"] objectAtIndex:0] stringValue];
        s._pitchFloorId = [[[screen elementsForName:@"_pitchFloorId"] objectAtIndex:0] stringValue];
        s._pitchMarksId = [[[screen elementsForName:@"_pitchMarksId"] objectAtIndex:0] stringValue];
        s._screenCategoryId = [[[screen elementsForName:@"_screenCategoryId"] objectAtIndex:0] stringValue];
        s._screenComments = [[[screen elementsForName:@"_screenComments"] objectAtIndex:0] stringValue];
        s._screenFormat = [[[screen elementsForName:@"_screenFormat"] objectAtIndex:0] stringValue];
        s._screenFormationOpposition = [[[screen elementsForName:@"_screenFormationOpposition"] objectAtIndex:0] stringValue];
        s._screenFormationOurs = [[[screen elementsForName:@"_screenFormationOurs"] objectAtIndex:0] stringValue];
        s._screenId = [[[screen elementsForName:@"_screenId"] objectAtIndex:0] stringValue];
        s._screenPlayerModelDisplay = [[[screen elementsForName:@"_screenPlayerModelDisplay"] objectAtIndex:0] stringValue];
        s._screenPlayerModelFormat = [[[screen elementsForName:@"_screenPlayerModelFormat"] objectAtIndex:0] stringValue];
        s._screenPlayerNameDisplay = [[[screen elementsForName:@"_screenPlayerNameDisplay"] objectAtIndex:0] stringValue];
        s._screenPlayerNameFormat = [[[screen elementsForName:@"_screenPlayerNameFormat"] objectAtIndex:0] stringValue];
        s._screenPlayerPositionDisplay = [[[screen elementsForName:@"_screenPlayerPositionDisplay"] objectAtIndex:0] stringValue];
        s._screenSortOrder = [[[screen elementsForName:@"_screenSortOrder"] objectAtIndex:0] stringValue];
        s._screenTitle = [[[screen elementsForName:@"_screenTitle"] objectAtIndex:0] stringValue];
        s._screenType = [[[screen elementsForName:@"_screenType"] objectAtIndex:0] stringValue];
        s._skillsPhysical = [[[screen elementsForName:@"_skillsPhysical"] objectAtIndex:0] stringValue];
        s._skillsPhysicalComment = [[[screen elementsForName:@"_skillsPhysicalComment"] objectAtIndex:0] stringValue];
        s._skillsPsychological = [[[screen elementsForName:@"_skillsPsychological"] objectAtIndex:0] stringValue];
        s._skillsPsychologicalComment = [[[screen elementsForName:@"_skillsPsychologicalComment"] objectAtIndex:0] stringValue];
        s._skillsSocial = [[[screen elementsForName:@"_skillsSocial"] objectAtIndex:0] stringValue];
        s._skillsSocialComment = [[[screen elementsForName:@"_skillsSocialComment"] objectAtIndex:0] stringValue];
        s._skillsTactical = [[[screen elementsForName:@"_skillsTactical"] objectAtIndex:0] stringValue];
        s._skillsTacticalComment = [[[screen elementsForName:@"_skillsTacticalComment"] objectAtIndex:0] stringValue];
        s._skillsTechnical = [[[screen elementsForName:@"_skillsTechnical"] objectAtIndex:0] stringValue];
        s._skillsTechnicalComment = [[[screen elementsForName:@"_skillsTechnicalComment"] objectAtIndex:0] stringValue];
        s._timeSpent = [[[screen elementsForName:@"_timeSpent"] objectAtIndex:0] stringValue];
        
        //解析equipment
        NSArray *equipmentArray = [screen elementsForName:@"equipment"];
        s.equipmentArray = [self parse_screen_equipmentArray:equipmentArray];
        
        //解析player
        NSArray *playerArray = [screen elementsForName:@"player"];
        s.playerArray = [self parse_screen_playerArray:playerArray];
        
        //解析pr_minutes
        NSArray *pr_minutesArray = [screen elementsForName:@"pr_minutes"];
        s.pr_minutesArray = [self parse_pr_minutesArray:pr_minutesArray];
        
        //解析session_minutes
        NSArray *session_minutesArray = [screen elementsForName:@"session_minutes"];
        s.session_minutesArray = [self parse_session_minutesArray:session_minutesArray];
        
        [arr addObject:s];
    }
    
    return arr;
}

//解析equipment
+ (NSMutableArray<Equipment *> *)parse_screen_equipmentArray:(NSArray *)equipmentArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *equipment in equipmentArray) {
        Equipment *e = [[Equipment alloc]init];
        e._equipColor = [[[equipment elementsForName:@"_equipColor"] objectAtIndex:0] stringValue];
        e._equipmentLibraryId = [[[equipment elementsForName:@"_equipmentLibraryId"] objectAtIndex:0] stringValue];
        e._flipH = [[[equipment elementsForName:@"_flipH"] objectAtIndex:0] stringValue];
        e._onlyDefaultPitches = [[[equipment elementsForName:@"_onlyDefaultPitches"] objectAtIndex:0] stringValue];
        e._pathData = [[[equipment elementsForName:@"_pathData"] objectAtIndex:0] stringValue];
        e._rotationY = [[[equipment elementsForName:@"_rotationY"] objectAtIndex:0] stringValue];
        e._transparency = [[[equipment elementsForName:@"_transparency"] objectAtIndex:0] stringValue];
        e._x = [[[equipment elementsForName:@"_x"] objectAtIndex:0] stringValue];
        e._y = [[[equipment elementsForName:@"_y"] objectAtIndex:0] stringValue];
        e._z = [[[equipment elementsForName:@"_z"] objectAtIndex:0] stringValue];
        [arr addObject:e];
    }
    return arr;
}

//解析player
+ (NSMutableArray<Screen_player *> *) parse_screen_playerArray:(NSArray *)playerArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *player in playerArray) {
        Screen_player *p = [[Screen_player alloc] init];
        p._accessories = [[[player elementsForName:@"_accessories"] objectAtIndex:0] stringValue];
        p._bottomColor = [[[player elementsForName:@"_bottomColor"] objectAtIndex:0] stringValue];
        p._flipH = [[[player elementsForName:@"_flipH"] objectAtIndex:0] stringValue];
        p._hairColor = [[[player elementsForName:@"_hairColor"] objectAtIndex:0] stringValue];
        p._hairType = [[[player elementsForName:@"_hairType"] objectAtIndex:0] stringValue];
        p._kitId = [[[player elementsForName:@"_kitId"] objectAtIndex:0] stringValue];
        p._kitTypeId = [[[player elementsForName:@"_kitTypeId"] objectAtIndex:0] stringValue];
        p._playerLibraryId = [[[player elementsForName:@"_playerLibraryId"] objectAtIndex:0] stringValue];
        p._playerNumber = [[[player elementsForName:@"_playerNumber"] objectAtIndex:0] stringValue];
        p._playerPositionId = [[[player elementsForName:@"_playerPositionId"] objectAtIndex:0] stringValue];
        p._rotationY = [[[player elementsForName:@"_rotationY"] objectAtIndex:0] stringValue];
        p._shoesColor = [[[player elementsForName:@"_shoesColor"] objectAtIndex:0] stringValue];
        p._skinColor = [[[player elementsForName:@"_skinColor"] objectAtIndex:0] stringValue];
        p._skinTexture = [[[player elementsForName:@"_skinTexture"] objectAtIndex:0] stringValue];
        p._socksColor = [[[player elementsForName:@"_socksColor"] objectAtIndex:0] stringValue];
        p._stripesColor = [[[player elementsForName:@"_stripesColor"] objectAtIndex:0] stringValue];
        p._stripesType = [[[player elementsForName:@"_stripesType"] objectAtIndex:0] stringValue];
        p._teamPlayerId = [[[player elementsForName:@"_teamPlayerId"] objectAtIndex:0] stringValue];
        p._topColor = [[[player elementsForName:@"_topColor"] objectAtIndex:0] stringValue];
        p._transparency = [[[player elementsForName:@"_transparency"] objectAtIndex:0] stringValue];
        p._x = [[[player elementsForName:@"_x"] objectAtIndex:0] stringValue];
        p._y = [[[player elementsForName:@"_y"] objectAtIndex:0] stringValue];
        p._z = [[[player elementsForName:@"_z"] objectAtIndex:0] stringValue];
        [arr addObject:p];
    }
    return arr;
}

//解析session_minutes
+ (NSMutableArray<Session_minutes *> *) parse_session_minutesArray:(NSArray *)session_minutesArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *session_minutes in session_minutesArray) {
        Session_minutes *s = [[Session_minutes alloc]init];
        s._activityCode = [[[session_minutes elementsForName:@"_activityCode"] objectAtIndex:0] stringValue];
        s._comment = [[[session_minutes elementsForName:@"_comment"] objectAtIndex:0] stringValue];
        s._playerId = [[[session_minutes elementsForName:@"_nonprTeamPlayerId"] objectAtIndex:0] stringValue];
        s._offset = [[[session_minutes elementsForName:@"_offset"] objectAtIndex:0] stringValue];
        s._screenId = [[[session_minutes elementsForName:@"_screenId"] objectAtIndex:0] stringValue];
        s._time = [[[session_minutes elementsForName:@"_time"] objectAtIndex:0] stringValue];
        [arr addObject:s];
    }
    return arr;
}

//解析screen_default
+ (NSMutableArray<Screen_defaults *> *) parse_session_screen_defaultArray:(NSArray *)screen_defaultArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *screen_default in screen_defaultArray) {
        Screen_defaults *s = [[Screen_defaults alloc]init];
        s._screenPlayerModelFormat = [[[screen_default elementsForName:@""] objectAtIndex:0] stringValue];
        s._screenPlayerNameFormat = [[[screen_default elementsForName:@""] objectAtIndex:0] stringValue];
        s._screenType = [[[screen_default elementsForName:@""] objectAtIndex:0] stringValue];
        [arr addObject:s];
    }
    return arr;
}

//解析video
+ (NSMutableArray<Video *> *) parse_videoArray:(NSArray *)videoArray {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (GDataXMLElement *video in videoArray) {
        Video *v = [[Video alloc]init];
        v._sortOrder = [[[video elementsForName:@"_sortOrder"] objectAtIndex:0] stringValue];
        v._thumbnailLocation = [[[video elementsForName:@"_thumbnailLocation"] objectAtIndex:0] stringValue];
        v._videoCode = [[[video elementsForName:@"_videoCode"] objectAtIndex:0] stringValue];
        v._videoDuration = [[[video elementsForName:@"_videoDuration"] objectAtIndex:0] stringValue];
        v._videoSource = [[[video elementsForName:@"_videoSource"] objectAtIndex:0] stringValue];
        v._videoTitle = [[[video elementsForName:@"_videoTitle"] objectAtIndex:0] stringValue];
        [arr addObject:v];
    }
    return arr;
}

#pragma mark - 生成xml
+ (GDataXMLDocument *)xmlDocFromFightModel:(FightModel *)fight withFileName:(NSString *)fileName {
    //根节点
    GDataXMLElement *root = [GDataXMLNode elementWithName:@"opt"];
    
    GDataXMLElement *_fixtureId = [GDataXMLNode elementWithName:@"_fixtureId" stringValue:fight._fixtureId];
    GDataXMLElement *_usePlayerRecords = [GDataXMLNode elementWithName:@"_usePlayerRecords" stringValue:fight._usePlayerRecords];
    
    [root addChild:_fixtureId];
    [root addChild:_usePlayerRecords];
    
    //生成nonpr_team_player
    for (Nonpr_team_player *p in fight.nonpr_team_playerArray) {
        [root addChild:[self nonpr_team_player:p]];
    }
    
    //生成player_position
    for (Player_position *p in fight.player_positionArray) {
        [root addChild:[self player_position:p]];
    }
    
    //生成pr_activity
    for (Pr_activity *p in fight.pr_activityArray) {
        [root addChild:[self pr_activity:p]];
    }
    
    //生成pr_minutes
    for (Pr_minutes *p in fight.pr_minutesArray) {
        [root addChild:[self pr_minutes:p]];
    }
    
    //生成pr_player
    for (Pr_player *p in fight.pr_playerArray) {
        [root addChild:[self pr_player:p]];
    }
    
    //生成pr_squad
    for (Pr_squad *p in fight.pr_squadArray) {
        [root addChild:[self pr_squad:p]];
    }
    
    //生成pr_team_player
    for (Pr_team_player *p in fight.pr_team_playerArray) {
        [root addChild:[self pr_team_player:p]];
    }
    
    //生成session
    [root addChild:[self session:fight.session]];
    
    //生成video
    for (Video *v in fight.videoArray) {
        [root addChild:[self video:v]];
    }
    
    
    
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc]initWithRootElement:root];
    
    [xmlDoc setCharacterEncoding:@"UTF-8"];
    [xmlDoc setVersion:@"1.0"];
    
    NSData *data = [xmlDoc XMLData];
    NSString *filePath = [getFightFilePath() stringByAppendingPathComponent:fileName];
    [data writeToFile:filePath atomically:YES];
    NSString *xmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", xmlString);
    return xmlDoc;
    
}

+ (GDataXMLElement *)nonpr_team_player:(Nonpr_team_player *)p {
    GDataXMLElement *nonpr_team_player = [GDataXMLNode elementWithName:@"nonpr_team_player"];
    
    GDataXMLElement *_familyName = [GDataXMLNode elementWithName:@"_familyName" stringValue:p._familyName];
    GDataXMLElement *_givenName = [GDataXMLNode elementWithName:@"_givenName" stringValue:p._givenName];
    GDataXMLElement *_nonprPlayerId = [GDataXMLNode elementWithName:@"_nonprPlayerId" stringValue:p._nonprPlayerId];
    GDataXMLElement *_playerNumber = [GDataXMLNode elementWithName:@"_playerNumber" stringValue:p._playerNumber];
    GDataXMLElement *_playerPositionId = [GDataXMLNode elementWithName:@"_playerPositionId" stringValue:p._playerPositionId];
    GDataXMLElement *_poseId = [GDataXMLNode elementWithName:@"_poseId" stringValue:p._poseId];
    GDataXMLElement *_sortOrder = [GDataXMLNode elementWithName:@"_sortOrder" stringValue:p._sortOrder];
    GDataXMLElement *_teamSide = [GDataXMLNode elementWithName:@"_teamSide" stringValue:p._teamSide];
    
    [nonpr_team_player addChild:_familyName];
    [nonpr_team_player addChild:_givenName];
    [nonpr_team_player addChild:_nonprPlayerId];
    [nonpr_team_player addChild:_playerNumber];
    [nonpr_team_player addChild:_playerPositionId];
    [nonpr_team_player addChild:_poseId];
    [nonpr_team_player addChild:_sortOrder];
    [nonpr_team_player addChild:_teamSide];
    
    return nonpr_team_player;
}

+ (GDataXMLElement *)player_position:(Player_position *)p {
    GDataXMLElement *player_position = [GDataXMLNode elementWithName:@"player_position"];
    
    GDataXMLElement *_isGoalkeeper = [GDataXMLNode elementWithName:@"_isGoalkeeper" stringValue:p._isGoalkeeper];
    GDataXMLElement *_playerPositionId = [GDataXMLNode elementWithName:@"_playerPositionId" stringValue:p._playerPositionId];
    GDataXMLElement *_playerPositionName = [GDataXMLNode elementWithName:@"_playerPositionName" stringValue:p._playerPositionName];
    
    [player_position addChild:_isGoalkeeper];
    [player_position addChild:_playerPositionId];
    [player_position addChild:_playerPositionName];
    return player_position;
}

+ (GDataXMLElement *)pr_activity:(Pr_activity *)p {
    GDataXMLElement *pr_activity = [GDataXMLNode elementWithName:@"pr_activity"];
    
    GDataXMLElement *_activityCode = [GDataXMLNode elementWithName:@"_activityCode" stringValue:p._activityCode];
    GDataXMLElement *_activityId = [GDataXMLNode elementWithName:@"_activityId" stringValue:p._activityId];
    GDataXMLElement *_activityName = [GDataXMLNode elementWithName:@"_activityName" stringValue:p._activityName];
    
    [pr_activity addChild:_activityCode];
    [pr_activity addChild:_activityId];
    [pr_activity addChild:_activityName];
    return pr_activity;
}

+ (GDataXMLElement *)pr_minutes:(Pr_minutes *)p {
    GDataXMLElement *pr_minutes = [GDataXMLNode elementWithName:@"pr_minutes"];
    
    GDataXMLElement *_activityCode = [GDataXMLNode elementWithName:@"_activityCode" stringValue:p._activityCode];
    GDataXMLElement *_comment = [GDataXMLNode elementWithName:@"_comment" stringValue:p._comment];
    GDataXMLElement *_offset = [GDataXMLNode elementWithName:@"_offset" stringValue:p._offset];
    GDataXMLElement *_screenId = [GDataXMLNode elementWithName:@"_screenId" stringValue:p._screenId];
    GDataXMLElement *_playerId = [GDataXMLNode elementWithName:@"_teamPlayerId" stringValue:p._playerId];
    GDataXMLElement *_time = [GDataXMLNode elementWithName:@"_time" stringValue:p._time];
    
    [pr_minutes addChild:_activityCode];
    [pr_minutes addChild:_comment];
    [pr_minutes addChild:_offset];
    [pr_minutes addChild:_screenId];
    [pr_minutes addChild:_playerId];
    [pr_minutes addChild:_time];
    return pr_minutes;
}

+ (GDataXMLElement *)pr_player:(Pr_player *) p {
    GDataXMLElement *pr_player = [GDataXMLNode elementWithName:@"pr_player"];
    
    GDataXMLElement *_familyName = [GDataXMLNode elementWithName:@"_familyName" stringValue:p._familyName];
    GDataXMLElement *_givenName = [GDataXMLNode elementWithName:@"_givenName" stringValue:p._givenName];
    GDataXMLElement *_prPlayerId = [GDataXMLNode elementWithName:@"_prPlayerId" stringValue:p._prPlayerId];
    
    [pr_player addChild:_familyName];
    [pr_player addChild:_givenName];
    [pr_player addChild:_prPlayerId];
    return pr_player;
}

+ (GDataXMLElement *)pr_squad:(Pr_squad *)p {
    GDataXMLElement *pr_squad = [GDataXMLNode elementWithName:@"pr_squad"];
    
    GDataXMLElement *_coachSquad = [GDataXMLNode elementWithName:@"_coachSquad" stringValue:p._coachSquad];
    GDataXMLElement *_squadId = [GDataXMLNode elementWithName:@"_squadId" stringValue:p._squadId];
    GDataXMLElement *_squadName = [GDataXMLNode elementWithName:@"_squadName" stringValue:p._squadName];
    
    [pr_squad addChild:_coachSquad];
    [pr_squad addChild:_squadId];
    [pr_squad addChild:_squadName];
    return pr_squad;
}

+ (GDataXMLElement *)pr_team_player:(Pr_team_player *)p {
    GDataXMLElement *pr_team_player = [GDataXMLNode elementWithName:@"pr_team_player"];
    
    GDataXMLElement *_lastTeam = [GDataXMLNode elementWithName:@"_lastTeam" stringValue:p._lastTeam];
    GDataXMLElement *_playerNumber = [GDataXMLNode elementWithName:@"_playerNumber" stringValue:p._playerNumber];
    GDataXMLElement *_playerPositionId = [GDataXMLNode elementWithName:@"_playerPositionId" stringValue:p._playerPositionId];
    GDataXMLElement *_poseId = [GDataXMLNode elementWithName:@"_poseId" stringValue:p._poseId];
    GDataXMLElement *_prPlayerId = [GDataXMLNode elementWithName:@"_prPlayerId" stringValue:p._prPlayerId];
    GDataXMLElement *_sortOrder = [GDataXMLNode elementWithName:@"_sortOrder" stringValue:p._sortOrder];
    GDataXMLElement *_squadId = [GDataXMLNode elementWithName:@"_squadId" stringValue:p._squadId];
    GDataXMLElement *_squadMember = [GDataXMLNode elementWithName:@"_squadMember" stringValue:p._squadMember];
    
    [pr_team_player addChild:_lastTeam];
    [pr_team_player addChild:_playerNumber];
    [pr_team_player addChild:_playerPositionId];
    [pr_team_player addChild:_poseId];
    [pr_team_player addChild:_prPlayerId];
    [pr_team_player addChild:_sortOrder];
    [pr_team_player addChild:_squadId];
    [pr_team_player addChild:_squadMember];
    return pr_team_player;
}

+ (GDataXMLElement *)session:(Session *)p {
    GDataXMLElement *session = [GDataXMLNode elementWithName:@"session"];
    
    GDataXMLElement *_globalFlipH = [GDataXMLNode elementWithName:@"_globalFlipH" stringValue:p._globalFlipH];
    GDataXMLElement *_globalSspToolVersion = [GDataXMLNode elementWithName:@"_globalSspToolVersion" stringValue:p._globalSspToolVersion];
    GDataXMLElement *_interfaceBaseUrl = [GDataXMLNode elementWithName:@"_interfaceBaseUrl" stringValue:p._interfaceBaseUrl];
    GDataXMLElement *_interfaceLanguageCode = [GDataXMLNode elementWithName:@"_interfaceLanguageCode" stringValue:p._interfaceLanguageCode];
    GDataXMLElement *_itemBaseUrl = [GDataXMLNode elementWithName:@"_itemBaseUrl" stringValue:p._itemBaseUrl];
    GDataXMLElement *_matchMinutes = [GDataXMLNode elementWithName:@"_matchMinutes" stringValue:p._matchMinutes];
    GDataXMLElement *_matchScoreOpposition = [GDataXMLNode elementWithName:@"_matchScoreOpposition" stringValue:p._matchScoreOpposition];
    GDataXMLElement *_matchScoreUs = [GDataXMLNode elementWithName:@"_matchScoreUs" stringValue:p._matchScoreUs];
    
    GDataXMLElement *_maxScreens = [GDataXMLNode elementWithName:@"_maxScreens" stringValue:p._maxScreens];
    GDataXMLElement *_screenTeamFlip = [GDataXMLNode elementWithName:@"_screenTeamFlip" stringValue:p._screenTeamFlip];
    GDataXMLElement *_sessionCategoryId = [GDataXMLNode elementWithName:@"_sessionCategoryId" stringValue:p._sessionCategoryId];
    GDataXMLElement *_sessionDifficultyLevelId = [GDataXMLNode elementWithName:@"_sessionDifficultyLevelId" stringValue:p._sessionDifficultyLevelId];
    GDataXMLElement *_sessionLanguageCode = [GDataXMLNode elementWithName:@"_sessionLanguageCode" stringValue:p._sessionLanguageCode];
    GDataXMLElement *_sessionOverallDescription = [GDataXMLNode elementWithName:@"_sessionOverallDescription" stringValue:p._sessionOverallDescription];
    GDataXMLElement *_sessionSkillLevelId = [GDataXMLNode elementWithName:@"_sessionSkillLevelId" stringValue:p._sessionSkillLevelId];
    GDataXMLElement *_sessionSport = [GDataXMLNode elementWithName:@"_sessionSport" stringValue:p._sessionSport];
    
    GDataXMLElement *_sessionStartTime = [GDataXMLNode elementWithName:@"_sessionStartTime" stringValue:p._sessionStartTime];
    GDataXMLElement *_sessionTitle = [GDataXMLNode elementWithName:@"_sessionTitle" stringValue:p._sessionTitle];
    GDataXMLElement *_sessionToken = [GDataXMLNode elementWithName:@"_sessionToken" stringValue:p._sessionToken];
    GDataXMLElement *_sessionType = [GDataXMLNode elementWithName:@"_sessionType" stringValue:p._sessionType];
    GDataXMLElement *_sessionUseSkillLevel = [GDataXMLNode elementWithName:@"_sessionUseSkillLevel" stringValue:p._sessionUseSkillLevel];
    GDataXMLElement *_teamNameOpposition = [GDataXMLNode elementWithName:@"_teamNameOpposition" stringValue:p._teamNameOpposition];
    GDataXMLElement *_teamNameOurs = [GDataXMLNode elementWithName:@"_teamNameOurs" stringValue:p._teamNameOurs];
    GDataXMLElement *_teamPlayerNameFormat = [GDataXMLNode elementWithName:@"_teamPlayerNameFormat" stringValue:p._teamPlayerNameFormat];
    
    GDataXMLElement *_teamPlayerNumberFormat = [GDataXMLNode elementWithName:@"_teamPlayerNumberFormat" stringValue:p._teamPlayerNumberFormat];
    GDataXMLElement *_teamPlayerPositionDisplay = [GDataXMLNode elementWithName:@"_teamPlayerPositionDisplay" stringValue:p._teamPlayerPositionDisplay];
    GDataXMLElement *_teamPlayersPerTeam = [GDataXMLNode elementWithName:@"_teamPlayersPerTeam" stringValue:p._teamPlayersPerTeam];
    GDataXMLElement *_teamWePlay = [GDataXMLNode elementWithName:@"_teamWePlay" stringValue:p._teamWePlay];
    GDataXMLElement *_userImageBase = [GDataXMLNode elementWithName:@"_userImageBase" stringValue:p._userImageBase];
    GDataXMLElement *_uuid = [GDataXMLNode elementWithName:@"_uuid" stringValue:p._uuid];
    GDataXMLElement *_xmlMySessionsRedirect = [GDataXMLNode elementWithName:@"_xmlMySessionsRedirect" stringValue:p._xmlMySessionsRedirect];
    GDataXMLElement *_xmlReceiveBase = [GDataXMLNode elementWithName:@"_xmlReceiveBase" stringValue:p._xmlReceiveBase];
    
    GDataXMLElement *_xmlSendBase = [GDataXMLNode elementWithName:@"_xmlSendBase" stringValue:p._xmlSendBase];
    GDataXMLElement *_xmlTeamBase = [GDataXMLNode elementWithName:@"_xmlTeamBase" stringValue:p._xmlTeamBase];
    GDataXMLElement *YioksOurTeamLeaderName = [GDataXMLNode elementWithName:@"YioksOurTeamLeaderName" stringValue:p.YioksOurTeamLeaderName];
    GDataXMLElement *YioksOurTeamLeaderSign = [GDataXMLNode elementWithName:@"YioksOurTeamLeaderSign" stringValue:p.YioksOurTeamLeaderSign];
    GDataXMLElement *YioksOppositionTeamLeaderName = [GDataXMLNode elementWithName:@"YioksOppositionTeamLeaderName" stringValue:p.YioksOppositionTeamLeaderName];
    GDataXMLElement *YioksOppositionTeamLeaderSign = [GDataXMLNode elementWithName:@"YioksOppositionTeamLeaderSign" stringValue:p.YioksOppositionTeamLeaderSign];
    GDataXMLElement *YioksRefreeName = [GDataXMLNode elementWithName:@"YioksRefreeName" stringValue:p.YioksRefreeName];
    GDataXMLElement *YioksRefreeSign = [GDataXMLNode elementWithName:@"YioksRefreeSign" stringValue:p.YioksRefreeSign];
    
    
    [session addChild:_globalFlipH];
    [session addChild:_globalSspToolVersion];
    [session addChild:_interfaceBaseUrl];
    [session addChild:_interfaceLanguageCode];
    [session addChild:_itemBaseUrl];
    [session addChild:_matchMinutes];
    [session addChild:_matchScoreOpposition];
    [session addChild:_matchScoreUs];
    
    [session addChild:_maxScreens];
    [session addChild:_screenTeamFlip];
    [session addChild:_sessionCategoryId];
    [session addChild:_sessionDifficultyLevelId];
    [session addChild:_sessionLanguageCode];
    [session addChild:_sessionOverallDescription];
    [session addChild:_sessionSkillLevelId];
    [session addChild:_sessionSport];
    
    [session addChild:_sessionStartTime];
    [session addChild:_sessionTitle];
    [session addChild:_sessionToken];
    [session addChild:_sessionType];
    [session addChild:_sessionUseSkillLevel];
    [session addChild:_teamNameOpposition];
    [session addChild:_teamNameOurs];
    [session addChild:_teamPlayerNameFormat];
    
    [session addChild:_teamPlayerNumberFormat];
    [session addChild:_teamPlayerPositionDisplay];
    [session addChild:_teamPlayersPerTeam];
    [session addChild:_teamWePlay];
    [session addChild:_userImageBase];
    [session addChild:_uuid];
    [session addChild:_xmlMySessionsRedirect];
    [session addChild:_xmlReceiveBase];
    
    [session addChild:_xmlSendBase];
    [session addChild:_xmlTeamBase];
    [session addChild:YioksOurTeamLeaderName];
    [session addChild:YioksOurTeamLeaderSign];
    [session addChild:YioksOppositionTeamLeaderName];
    [session addChild:YioksOppositionTeamLeaderSign];
    [session addChild:YioksRefreeName];
    [session addChild:YioksRefreeSign];
    
    //解析kit
    for (Kit *k in p.kitArray) {
        [session addChild:[self kit:k]];
    }
    
    //解析lines_library
    for (Lines_library *l in p.lines_libraryArray) {
        [session addChild:[self lines_library:l]];
    }
    
    //解析link_item
    for (Link_item *link in p.link_itemArray) {
        [session addChild:[self link_item:link]];
    }
    
    //解析screen
    for (Screen *s in p.screenArray) {
        [session addChild:[self screen:s]];
    }
    
    //解析screen_defaults
    for (Screen_defaults *sd in p.screen_defaultArray) {
        [session addChild:[self screen_defaults:sd]];
    }
    
    
    
    return session;
}

+ (GDataXMLElement *) kit:(Kit *) p {
    GDataXMLElement *kit = [GDataXMLNode elementWithName:@"kit"];
    
    GDataXMLElement *_bottomColor = [GDataXMLNode elementWithName:@"_bottomColor" stringValue:p._bottomColor];
    GDataXMLElement *_hairColor = [GDataXMLNode elementWithName:@"_hairColor" stringValue:p._hairColor];
    GDataXMLElement *_hairType = [GDataXMLNode elementWithName:@"_hairType" stringValue:p._hairType];
    GDataXMLElement *_kitId = [GDataXMLNode elementWithName:@"_kitId" stringValue:p._kitId];
    GDataXMLElement *_kitTypeId = [GDataXMLNode elementWithName:@"_kitTypeId" stringValue:p._kitTypeId];
    GDataXMLElement *_shoesColor = [GDataXMLNode elementWithName:@"_shoesColor" stringValue:p._shoesColor];
    GDataXMLElement *_skinColor = [GDataXMLNode elementWithName:@"_skinColor" stringValue:p._skinColor];
    GDataXMLElement *_skinTexture = [GDataXMLNode elementWithName:@"_skinTexture" stringValue:p._skinTexture];
    GDataXMLElement *_socksColor = [GDataXMLNode elementWithName:@"_socksColor" stringValue:p._socksColor];
    GDataXMLElement *_stripesColor = [GDataXMLNode elementWithName:@"_stripesColor" stringValue:p._stripesColor];
    GDataXMLElement *_stripesType = [GDataXMLNode elementWithName:@"_stripesType" stringValue:p._stripesType];
    GDataXMLElement *_topColor = [GDataXMLNode elementWithName:@"_topColor" stringValue:p._topColor];
    
    [kit addChild:_bottomColor];
    [kit addChild:_hairColor];
    [kit addChild:_hairType];
    [kit addChild:_kitId];
    [kit addChild:_kitTypeId];
    [kit addChild:_shoesColor];
    [kit addChild:_skinColor];
    [kit addChild:_skinTexture];
    [kit addChild:_socksColor];
    [kit addChild:_stripesColor];
    [kit addChild:_stripesType];
    [kit addChild:_topColor];
    return kit;
}

+ (GDataXMLElement *)lines_library:(Lines_library *)p {
    GDataXMLElement *lines_library = [GDataXMLNode elementWithName:@"lines_library"];
    
    GDataXMLElement *_arrowThickness = [GDataXMLNode elementWithName:@"_arrowThickness" stringValue:p._arrowThickness];
    GDataXMLElement *_lineColor = [GDataXMLNode elementWithName:@"_lineColor" stringValue:p._lineColor];
    GDataXMLElement *_lineStyle = [GDataXMLNode elementWithName:@"_lineStyle" stringValue:p._lineStyle];
    GDataXMLElement *_lineThickness = [GDataXMLNode elementWithName:@"_lineThickness" stringValue:p._lineThickness];
    GDataXMLElement *_lineType = [GDataXMLNode elementWithName:@"_lineType" stringValue:p._lineType];
    GDataXMLElement *_linesLibraryId = [GDataXMLNode elementWithName:@"_linesLibraryId" stringValue:p._linesLibraryId];
    GDataXMLElement *_useArrowHead = [GDataXMLNode elementWithName:@"_useArrowHead" stringValue:p._useArrowHead];
    GDataXMLElement *_useHandles = [GDataXMLNode elementWithName:@"_useHandles" stringValue:p._useHandles];
    
    [lines_library addChild:_arrowThickness];
    [lines_library addChild:_lineColor];
    [lines_library addChild:_lineStyle];
    [lines_library addChild:_lineThickness];
    [lines_library addChild:_lineType];
    [lines_library addChild:_linesLibraryId];
    [lines_library addChild:_useArrowHead];
    [lines_library addChild:_useHandles];
    return lines_library;
}

+ (GDataXMLElement *)link_item:(Link_item *)p {
    GDataXMLElement *link_item = [GDataXMLElement elementWithName:@"link_item"];
    GDataXMLElement *_itemCode = [GDataXMLNode elementWithName:@"_itemCode" stringValue:p._itemCode];
    GDataXMLElement *_itemLocation = [GDataXMLNode elementWithName:@"_itemLocation" stringValue:p._itemLocation];
    [link_item addChild:_itemCode];
    [link_item addChild:_itemLocation];
    return link_item;
}

+ (GDataXMLElement *)screen:(Screen *)p {
    GDataXMLElement *screen = [GDataXMLNode elementWithName:@"screen"];
    
    GDataXMLElement *_cameraFOV = [GDataXMLNode elementWithName:@"_cameraFOV" stringValue:p._cameraFOV];
    GDataXMLElement *_cameraPanAngle = [GDataXMLNode elementWithName:@"_cameraPanAngle" stringValue:p._cameraPanAngle];
    GDataXMLElement *_cameraTarget = [GDataXMLNode elementWithName:@"_cameraTarget" stringValue:p._cameraTarget];
    GDataXMLElement *_cameraTiltAngle = [GDataXMLNode elementWithName:@"_cameraTiltAngle" stringValue:p._cameraTiltAngle];
    GDataXMLElement *_cameraType = [GDataXMLNode elementWithName:@"_cameraType" stringValue:p._cameraType];
    GDataXMLElement *_cameraZoom = [GDataXMLNode elementWithName:@"_cameraZoom" stringValue:p._cameraZoom];
    GDataXMLElement *_dbTransitionId = [GDataXMLNode elementWithName:@"_dbTransitionId" stringValue:p._dbTransitionId];
    GDataXMLElement *_globalObjScale = [GDataXMLNode elementWithName:@"_globalObjScale" stringValue:p._globalObjScale];
    
    GDataXMLElement *_globalRotationY = [GDataXMLNode elementWithName:@"_globalRotationY" stringValue:p._globalRotationY];
    GDataXMLElement *_pitchFloorId = [GDataXMLNode elementWithName:@"_pitchFloorId" stringValue:p._pitchFloorId];
    GDataXMLElement *_pitchMarksId = [GDataXMLNode elementWithName:@"_pitchMarksId" stringValue:p._pitchMarksId];
    GDataXMLElement *_screenCategoryId = [GDataXMLNode elementWithName:@"_screenCategoryId" stringValue:p._screenCategoryId];
    GDataXMLElement *_screenComments = [GDataXMLNode elementWithName:@"_screenComments" stringValue:p._screenComments];
    GDataXMLElement *_screenFormat = [GDataXMLNode elementWithName:@"_screenFormat" stringValue:p._screenFormat];
    GDataXMLElement *_screenFormationOpposition = [GDataXMLNode elementWithName:@"_screenFormationOpposition" stringValue:p._screenFormationOpposition];
    GDataXMLElement *_screenFormationOurs = [GDataXMLNode elementWithName:@"_screenFormationOurs" stringValue:p._screenFormationOurs];
    
    GDataXMLElement *_screenId = [GDataXMLNode elementWithName:@"_screenId" stringValue:p._screenId];
    GDataXMLElement *_screenPlayerModelDisplay = [GDataXMLNode elementWithName:@"_screenPlayerModelDisplay" stringValue:p._screenPlayerModelDisplay];
    GDataXMLElement *_screenPlayerModelFormat = [GDataXMLNode elementWithName:@"_screenPlayerModelFormat" stringValue:p._screenPlayerModelFormat];
    GDataXMLElement *_screenPlayerNameDisplay = [GDataXMLNode elementWithName:@"_screenPlayerNameDisplay" stringValue:p._screenPlayerNameDisplay];
    GDataXMLElement *_screenPlayerNameFormat = [GDataXMLNode elementWithName:@"_screenPlayerNameFormat" stringValue:p._screenPlayerNameFormat];
    GDataXMLElement *_screenPlayerPositionDisplay = [GDataXMLNode elementWithName:@"_screenPlayerPositionDisplay" stringValue:p._screenPlayerPositionDisplay];
    GDataXMLElement *_screenSortOrder = [GDataXMLNode elementWithName:@"_screenSortOrder" stringValue:p._screenSortOrder];
    GDataXMLElement *_screenTitle = [GDataXMLNode elementWithName:@"_screenTitle" stringValue:p._screenTitle];
    
    GDataXMLElement *_screenType = [GDataXMLNode elementWithName:@"_screenType" stringValue:p._screenType];
    GDataXMLElement *_skillsPhysical = [GDataXMLNode elementWithName:@"_skillsPhysical" stringValue:p._skillsPhysical];
    GDataXMLElement *_skillsPhysicalComment = [GDataXMLNode elementWithName:@"_skillsPhysicalComment" stringValue:p._skillsPhysicalComment];
    GDataXMLElement *_skillsPsychological = [GDataXMLNode elementWithName:@"_skillsPsychological" stringValue:p._skillsPsychological];
    GDataXMLElement *_skillsPsychologicalComment = [GDataXMLNode elementWithName:@"_skillsPsychologicalComment" stringValue:p._skillsPsychologicalComment];
    GDataXMLElement *_skillsSocial = [GDataXMLNode elementWithName:@"_skillsSocial" stringValue:p._skillsSocial];
    GDataXMLElement *_skillsSocialComment = [GDataXMLNode elementWithName:@"_skillsSocialComment" stringValue:p._skillsSocialComment];
    GDataXMLElement *_skillsTactical = [GDataXMLNode elementWithName:@"_skillsTactical" stringValue:p._skillsTactical];
    
    GDataXMLElement *_skillsTacticalComment = [GDataXMLNode elementWithName:@"_skillsTacticalComment" stringValue:p._skillsTacticalComment];
    GDataXMLElement *_skillsTechnical = [GDataXMLNode elementWithName:@"_skillsTechnical" stringValue:p._skillsTechnical];
    GDataXMLElement *_skillsTechnicalComment = [GDataXMLNode elementWithName:@"_skillsTechnicalComment" stringValue:p._skillsTechnicalComment];
    GDataXMLElement *_timeSpent = [GDataXMLNode elementWithName:@"_timeSpent" stringValue:p._timeSpent];
    
    
    [screen addChild:_cameraFOV];
    [screen addChild:_cameraPanAngle];
    [screen addChild:_cameraTarget];
    [screen addChild:_cameraTiltAngle];
    [screen addChild:_cameraType];
    [screen addChild:_cameraZoom];
    [screen addChild:_dbTransitionId];
    [screen addChild:_globalObjScale];
    
    [screen addChild:_globalRotationY];
    [screen addChild:_pitchFloorId];
    [screen addChild:_pitchMarksId];
    [screen addChild:_screenCategoryId];
    [screen addChild:_screenComments];
    [screen addChild:_screenFormat];
    [screen addChild:_screenFormationOpposition];
    [screen addChild:_screenFormationOurs];
    
    [screen addChild:_screenId];
    [screen addChild:_screenPlayerModelDisplay];
    [screen addChild:_screenPlayerModelFormat];
    [screen addChild:_screenPlayerNameDisplay];
    [screen addChild:_screenPlayerNameFormat];
    [screen addChild:_screenPlayerPositionDisplay];
    [screen addChild:_screenSortOrder];
    [screen addChild:_screenTitle];
    
    [screen addChild:_screenType];
    [screen addChild:_skillsPhysical];
    [screen addChild:_skillsPhysicalComment];
    [screen addChild:_skillsPsychological];
    [screen addChild:_skillsPsychologicalComment];
    [screen addChild:_skillsSocial];
    [screen addChild:_skillsSocialComment];
    [screen addChild:_skillsTactical];
    
    [screen addChild:_skillsTacticalComment];
    [screen addChild:_skillsTechnical];
    [screen addChild:_skillsTechnicalComment];
    [screen addChild:_timeSpent];
    
    //解析equipmnt
    for (Equipment *e in p.equipmentArray) {
        [screen addChild:[self equipment:e]];
    }
    
    //解析player
    for (Screen_player *s in p.playerArray) {
        [screen addChild:[self player:s]];
    }
    
    //解析pr_minutes
    for (Pr_minutes *pm in p.pr_minutesArray) {
        [screen addChild:[self pr_minutes:pm]];
    }
    
    //解析session_minutes
    for (Session_minutes *sm in p.session_minutesArray) {
        [screen addChild:[self session_minutes:sm]];
    }
    
    return screen;
}

+ (GDataXMLElement *)equipment:(Equipment *) p {
    GDataXMLElement *equipment = [GDataXMLNode elementWithName:@"equipment"];
    
    GDataXMLElement *_equipColor = [GDataXMLNode elementWithName:@"_equipColor" stringValue:p._equipColor];
    GDataXMLElement *_equipmentLibraryId = [GDataXMLNode elementWithName:@"_equipmentLibraryId" stringValue:p._equipmentLibraryId];
    GDataXMLElement *_flipH = [GDataXMLNode elementWithName:@"_flipH" stringValue:p._flipH];
    GDataXMLElement *_onlyDefaultPitches = [GDataXMLNode elementWithName:@"_onlyDefaultPitches" stringValue:p._onlyDefaultPitches];
    GDataXMLElement *_pathData = [GDataXMLNode elementWithName:@"_pathData" stringValue:p._pathData];
    GDataXMLElement *_rotationY = [GDataXMLNode elementWithName:@"_rotationY" stringValue:p._rotationY];
    GDataXMLElement *_transparency = [GDataXMLNode elementWithName:@"_transparency" stringValue:p._transparency];
    GDataXMLElement *_x = [GDataXMLNode elementWithName:@"_x" stringValue:p._x];
    GDataXMLElement *_y = [GDataXMLNode elementWithName:@"_y" stringValue:p._y];
    GDataXMLElement *_z = [GDataXMLNode elementWithName:@"_z" stringValue:p._z];
    
    [equipment addChild:_equipColor];
    [equipment addChild:_equipmentLibraryId];
    [equipment addChild:_flipH];
    [equipment addChild:_onlyDefaultPitches];
    [equipment addChild:_pathData];
    [equipment addChild:_rotationY];
    [equipment addChild:_transparency];
    [equipment addChild:_x];
    [equipment addChild:_y];
    [equipment addChild:_z];
    return equipment;
}

+ (GDataXMLElement *)player:(Screen_player *)p {
    GDataXMLElement *player = [GDataXMLNode elementWithName:@"player"];
    
    GDataXMLElement *_accessories = [GDataXMLNode elementWithName:@"_accessories" stringValue:p._accessories];
    GDataXMLElement *_bottomColor = [GDataXMLNode elementWithName:@"_bottomColor" stringValue:p._bottomColor];
    GDataXMLElement *_flipH = [GDataXMLNode elementWithName:@"_flipH" stringValue:p._flipH];
    GDataXMLElement *_hairColor = [GDataXMLNode elementWithName:@"_hairColor" stringValue:p._hairColor];
    GDataXMLElement *_hairType = [GDataXMLNode elementWithName:@"_hairType" stringValue:p._hairType];
    GDataXMLElement *_kitId = [GDataXMLNode elementWithName:@"_kitId" stringValue:p._kitId];
    GDataXMLElement *_kitTypeId = [GDataXMLNode elementWithName:@"_kitTypeId" stringValue:p._kitTypeId];
    GDataXMLElement *_playerLibraryId = [GDataXMLNode elementWithName:@"_playerLibraryId" stringValue:p._playerLibraryId];
    GDataXMLElement *_playerNumber = [GDataXMLNode elementWithName:@"_playerNumber" stringValue:p._playerNumber];
    GDataXMLElement *_playerPositionId = [GDataXMLNode elementWithName:@"_playerPositionId" stringValue:p._playerPositionId];
    GDataXMLElement *_rotationY = [GDataXMLNode elementWithName:@"_rotationY" stringValue:p._rotationY];
    GDataXMLElement *_shoesColor = [GDataXMLNode elementWithName:@"_shoesColor" stringValue:p._shoesColor];
    GDataXMLElement *_skinColor = [GDataXMLNode elementWithName:@"_skinColor" stringValue:p._skinColor];
    GDataXMLElement *_skinTexture = [GDataXMLNode elementWithName:@"_skinTexture" stringValue:p._skinTexture];
    GDataXMLElement *_socksColor = [GDataXMLNode elementWithName:@"_socksColor" stringValue:p._socksColor];
    GDataXMLElement *_stripesColor = [GDataXMLNode elementWithName:@"_stripesColor" stringValue:p._stripesColor];
    GDataXMLElement *_stripesType = [GDataXMLNode elementWithName:@"_stripesType" stringValue:p._stripesType];
    GDataXMLElement *_teamPlayerId = [GDataXMLNode elementWithName:@"_teamPlayerId" stringValue:p._teamPlayerId];
    GDataXMLElement *_topColor = [GDataXMLNode elementWithName:@"_topColor" stringValue:p._topColor];
    GDataXMLElement *_transparency = [GDataXMLNode elementWithName:@"_transparency" stringValue:p._transparency];
    GDataXMLElement *_x = [GDataXMLNode elementWithName:@"_x" stringValue:p._x];
    GDataXMLElement *_y = [GDataXMLNode elementWithName:@"_y" stringValue:p._y];
    GDataXMLElement *_z = [GDataXMLNode elementWithName:@"_z" stringValue:p._z];
    
    
    [player addChild:_accessories];
    [player addChild:_bottomColor];
    [player addChild:_flipH];
    [player addChild:_hairColor];
    [player addChild:_hairType];
    [player addChild:_kitId];
    [player addChild:_kitTypeId];
    [player addChild:_playerLibraryId];
    [player addChild:_playerNumber];
    [player addChild:_playerPositionId];
    [player addChild:_rotationY];
    [player addChild:_shoesColor];
    [player addChild:_skinColor];
    [player addChild:_skinTexture];
    [player addChild:_socksColor];
    [player addChild:_stripesColor];
    [player addChild:_stripesType];
    [player addChild:_teamPlayerId];
    [player addChild:_topColor];
    [player addChild:_transparency];
    [player addChild:_x];
    [player addChild:_y];
    [player addChild:_z];
    return player;
}

+ (GDataXMLElement *)session_minutes:(Session_minutes *) p {
    GDataXMLElement *session_minutes = [GDataXMLNode elementWithName:@"session_minutes"];
    
    GDataXMLElement *_activityCode = [GDataXMLNode elementWithName:@"_activityCode" stringValue:p._activityCode];
    GDataXMLElement *_comment = [GDataXMLNode elementWithName:@"_comment" stringValue:p._comment];
    GDataXMLElement *_playerId = [GDataXMLNode elementWithName:@"_nonprTeamPlayerId" stringValue:p._playerId];
    GDataXMLElement *_offset = [GDataXMLNode elementWithName:@"_offset" stringValue:p._offset];
    GDataXMLElement *_screenId = [GDataXMLNode elementWithName:@"_screenId" stringValue:p._screenId];
    GDataXMLElement *_time = [GDataXMLNode elementWithName:@"_time" stringValue:p._time];
    
    [session_minutes addChild:_activityCode];
    [session_minutes addChild:_comment];
    [session_minutes addChild:_playerId];
    [session_minutes addChild:_offset];
    [session_minutes addChild:_screenId];
    [session_minutes addChild:_time];
    return session_minutes;
}

+ (GDataXMLElement *)screen_defaults:(Screen_defaults *)p {
    GDataXMLElement *screen_defaults = [GDataXMLNode elementWithName:@"screen_defaults"];
    
    GDataXMLElement *_screenPlayerModelFormat = [GDataXMLNode elementWithName:@"_screenPlayerModelFormat" stringValue:p._screenPlayerModelFormat];
    GDataXMLElement *_screenPlayerNameFormat = [GDataXMLNode elementWithName:@"_screenPlayerNameFormat" stringValue:p._screenPlayerNameFormat];
    GDataXMLElement *_screenType = [GDataXMLNode elementWithName:@"_screenType" stringValue:p._screenType];
    
    [screen_defaults addChild:_screenPlayerModelFormat];
    [screen_defaults addChild:_screenPlayerNameFormat];
    [screen_defaults addChild:_screenType];
    return screen_defaults;
}

+ (GDataXMLElement *)video:(Video *)p {
    GDataXMLElement *video = [GDataXMLNode elementWithName:@"video"];
    
    GDataXMLElement *_sortOrder = [GDataXMLNode elementWithName:@"_sortOrder" stringValue:p._sortOrder];
    GDataXMLElement *_thumbnailLocation = [GDataXMLNode elementWithName:@"_thumbnailLocation" stringValue:p._thumbnailLocation];
    GDataXMLElement *_videoCode = [GDataXMLNode elementWithName:@"_videoCode" stringValue:p._videoCode];
    GDataXMLElement *_videoDuration = [GDataXMLNode elementWithName:@"_videoDuration" stringValue:p._videoDuration];
    GDataXMLElement *_videoSource = [GDataXMLNode elementWithName:@"_videoSource" stringValue:p._videoSource];
    GDataXMLElement *_videoTitle = [GDataXMLNode elementWithName:@"_videoTitle" stringValue:p._videoTitle];
    
    [video addChild:_sortOrder];
    [video addChild:_thumbnailLocation];
    [video addChild:_videoCode];
    [video addChild:_videoDuration];
    [video addChild:_videoSource];
    [video addChild:_videoTitle];
    return video;
}

//#pragma mark - 利用runtime合成
//+ (GDataXMLDocument *)xmlDocFromFightModelByRuntimeModel:(FightModel *)fight {
//    
//}




@end
