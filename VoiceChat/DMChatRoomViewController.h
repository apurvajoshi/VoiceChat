//
//  DMChatRoomViewController.h
//  VoiceChat
//
//  Created by Apurva Joshi on 5/31/14.
//  Copyright (c) 2014 SayIt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "chatCell.h"
//#import "Reachability.h"
#import "PersonContact.h"


@interface DMChatRoomViewController : UIViewController <UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource, PF_EGORefreshTableHeaderDelegate>

{
    IBOutlet UITextField *tfEntry;
    IBOutlet UITableView    *chatTable;
    NSMutableArray          *chatData;
    PF_EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    NSString                *className;
    //NSString                *userName;
    
}
@property (nonatomic,strong) IBOutlet UITextField *tfEntry;
@property (nonatomic, retain) UITableView *chatTable;
@property (nonatomic, retain) NSArray *chatData;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) PersonContact *chatWithPerson;

-(void) registerForKeyboardNotifications;
-(void) freeKeyboardNotifications;
-(void) keyboardWasShown:(NSNotification*)aNotification;
-(void) keyboardWillHide:(NSNotification*)aNotification;

- (void)loadLocalChat;

-(void)presentChatNameDialog;

@end