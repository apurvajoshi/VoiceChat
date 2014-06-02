//
//  ContactDetailViewController.h
//  VoiceChat
//
//  Created by Sunil Kumar  Devalokam Murali on 6/1/14.
//  Copyright (c) 2014 SayIt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactDetailViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *personContactLabel;
@property (nonatomic, strong) NSString *personContactName;
@end
