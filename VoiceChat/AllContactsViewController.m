//
//  AllContactsViewController.m
//  VoiceChat
//
//  Created by Sunil Kumar  Devalokam Murali on 6/1/14.
//  Copyright (c) 2014 SayIt. All rights reserved.
//

#import "AllContactsViewController.h"
#import "ContactDetailViewController.h"


@interface AllContactsViewController ()

@end

@implementation AllContactsViewController
NSMutableArray *contacts;
CFErrorRef *error = NULL;
ABAddressBookRef addressBook = NULL;
@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.tableView.contentInset = UIEdgeInsetsMake(0., 0., CGRectGetHeight(self.tabBarController.tabBar.frame), 0);
    
    addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined)
    {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     if (granted == NO)
                                                     {
                                                         NSLog(@"User DENIED access to Contacts!");
                                                         // Show an alert for no contact Access
                                                     }
                                                 });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
    {
        NSLog(@"User ALREADY HAS access to Contacts!");
        // The user has previously given access, good to go
    }
    else
    {
        NSLog(@"User previously DENIED access to Contacts!");
        // The user has previously denied access
        // Send an alert telling user to change privacy setting in settings app
    }
    
    contacts = [self getAllContacts];
}

- (NSMutableArray*) getAllContacts {
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    NSMutableArray *contactList = [[NSMutableArray alloc] init];
    
    
    for(int i = 0; i < numberOfPeople; i++) {
        
        ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
        
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        //NSLog(@"Name:%@ %@", firstName, lastName);
        
        NSString *fullName = [NSString stringWithFormat: @"%@ %@",firstName, lastName];
        [contactList addObject:fullName];
        //NSLog(@"%@", fullName);
        
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        for (CFIndex i = 0; i < ABMultiValueGetCount(phoneNumbers); i++) {
            NSString *phoneNumber = (__bridge_transfer NSString *) ABMultiValueCopyValueAtIndex(phoneNumbers, i);
            //NSLog(@"phone:%@", phoneNumber);
        }
    }
    
    [contactList sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return contactList;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PersonContact";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [contacts objectAtIndex:indexPath.row];
    return cell;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    return NO;
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    //[_addressBookController dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPersonContactDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ContactDetailViewController *destViewController = segue.destinationViewController;
        destViewController.personContactName = [contacts objectAtIndex:indexPath.row];
    }
}

@end
