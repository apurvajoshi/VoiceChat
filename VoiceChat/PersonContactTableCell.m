//
//  PersonContactTableCell.m
//  VoiceChat
//
//  Created by Sunil Kumar  Devalokam Murali on 6/5/14.
//  Copyright (c) 2014 SayIt. All rights reserved.
//

#import "PersonContactTableCell.h"

@implementation PersonContactTableCell

//@synthesize nameLabel = _nameLabel;;

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
