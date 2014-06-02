//
//  AllContactsViewController.h
//  VoiceChat
//
//  Created by Sunil Kumar  Devalokam Murali on 6/1/14.
//  Copyright (c) 2014 SayIt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface AllContactsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,ABPeoplePickerNavigationControllerDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
