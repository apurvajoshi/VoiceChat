//
//  chatCell.h
//  VoiceChat
//
//  Created by Apurva Joshi on 5/26/14.
//  Copyright (c) 2014 SayIt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chatCell : UITableViewCell
{
    IBOutlet UILabel *userLabel;
    IBOutlet UITextView *textString;
    IBOutlet UILabel *timeLabel;
}

@property (nonatomic,retain) IBOutlet UILabel *userLabel;
@property (nonatomic,retain) IBOutlet UITextView *textString;
@property (nonatomic,retain) IBOutlet UILabel *timeLabel;

@end
