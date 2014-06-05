//
//  FavoritiesViewController.m
//  VoiceChat
//
//  Created by Sunil Kumar  Devalokam Murali on 6/1/14.
//  Copyright (c) 2014 SayIt. All rights reserved.
//

#import "FavoritiesViewController.h"
#import <Parse/Parse.h>
#import "DMChatRoomViewController.h"

@interface FavoritiesViewController ()

@end

@implementation FavoritiesViewController

CFErrorRef *faverror = NULL;
NSMutableArray *favoritiesContacts;
ABAddressBookRef favoritiesAddressBook = NULL;

@synthesize favoritiesTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Inside Favorities View Controller");
    favoritiesAddressBook = ABAddressBookCreateWithOptions(NULL, faverror);
    favoritiesContacts = [self getAllContacts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray*) getAllContacts {
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(favoritiesAddressBook);
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(favoritiesAddressBook);
    NSMutableArray *contactList = [[NSMutableArray alloc] init];
    NSMutableArray *phoneList = [[NSMutableArray alloc] init];
    
    
    for(int i = 0; i < numberOfPeople; i++) {
        
        ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
        
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        
        NSString *fullName = [NSString stringWithFormat: @"%@ %@",firstName, lastName];
        //NSLog(@"%@", fullName);
        
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        for (CFIndex i = 0; i < ABMultiValueGetCount(phoneNumbers); i++) {
            NSString *phoneNumber = (__bridge_transfer NSString *) ABMultiValueCopyValueAtIndex(phoneNumbers, i);
            phoneNumber = [[phoneNumber componentsSeparatedByCharactersInSet:
                            [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                           componentsJoinedByString:@""];
            [phoneList addObject:phoneNumber];
        }
    }
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"phone" containedIn:phoneList];
    NSArray *users = [query findObjects];
    NSLog(@"Successfully retrieved %d contacts.", users.count);
    for (PFUser *user in users) {
        NSLog(@"%@", user.username);
        [contactList addObject:user.username];
    }
    
    [contactList sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return contactList;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [favoritiesContacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FavoritiesPersonContact";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [favoritiesContacts objectAtIndex:indexPath.row];
    return cell;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showChat"]) {
        NSIndexPath *indexPath = [self.favoritiesTableView indexPathForSelectedRow];
        DMChatRoomViewController *destViewController = segue.destinationViewController;
        //destViewController.userName = [favoritiesContacts objectAtIndex:indexPath.row];
        destViewController.userName = @"test123";
        destViewController.hidesBottomBarWhenPushed = YES;
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
