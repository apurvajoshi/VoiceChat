//
//  chatCell.m
//  VoiceChat
//
//  Created by Apurva Joshi on 5/26/14.
//  Copyright (c) 2014 SayIt. All rights reserved.
//

#import "chatCell.h"

@implementation chatCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
