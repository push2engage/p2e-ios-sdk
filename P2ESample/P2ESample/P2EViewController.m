//
//  P2EViewController.m
//  P2EPush
//
//  Created by Push2Engage on 01/28/2016.
//  Copyright (c) 2016 Push2Engage. All rights reserved.
//

#import "P2EViewController.h"
#import <P2EPush/P2E.h>

static NSString *const checkQuiteTime = @"Check quite time status?";
static NSString *const enableQuiteTime = @"Enable quite time";
static NSString *const disableQuiteTime = @"Disbale quite time";
static NSString *const addTag = @"Add Tag";
static NSString *const group = @"Group Name";
static NSString *const addTagInGroup = @"Add Tag in Group";
static NSString *const removeTag = @"Remove Tag";
static NSString *const removeTagInGroup = @"Remove Tag in Group";
static NSString *const updateBadgeCount = @"Update Badge count";
static NSString *const resetBadgeCount = @"Reset Badge count";
static NSString *const incrementBadgeCount = @"Increment Badge count";
static NSString *const decrementBadgeCount = @"Decrease badge count";
static NSString *const sendLocation = @"Send Location";
static NSString *const addAlias = @"Add Alias";
static NSString *const addEmail = @"Add Email";

static NSString *const tag = @"Tag";
static NSString *const badge = @"Badge";

@interface P2EViewController ()

@property NSArray *dataArray;

@end

@implementation P2EViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    //_dataArray = @[checkQuiteTime, enableQuiteTime, disableQuiteTime, addTag, addTagInGroup, removeTag, removeTagInGroup, updateBadgeCount, resetBadgeCount, incrementBadgeCount, decrementBadgeCount, sendLocation];
    _dataArray = @[tag, badge, checkQuiteTime, enableQuiteTime, disableQuiteTime,sendLocation, addAlias, addEmail];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MainBasicCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainBasicCell" forIndexPath:indexPath];
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    
    if ([cellText isEqualToString:checkQuiteTime]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Quite Time" message:[NSString stringWithFormat:@"Quite time enabled? : %@", [Push isQuietTimeEnabled]?@"Yes":@"No"] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok action") style:UIAlertActionStyleDestructive handler:nil];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if ([cellText isEqualToString:enableQuiteTime]) {
        [self performSegueWithIdentifier:@"quietTimeController" sender:self];
    }
    else if ([cellText isEqualToString:disableQuiteTime]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:disableQuiteTime message:@"Quite time disabled." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok action") style:UIAlertActionStyleDestructive handler:nil];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        [Push disableQuietTime];
    }
    else if ([cellText isEqualToString:sendLocation]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:sendLocation message:@"Location sent to server" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok action") style:UIAlertActionStyleDestructive handler:nil];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        [Push sendLocation];
    }
    else if ([cellText isEqualToString:tag]) {
        [self performSegueWithIdentifier:@"tagViewController" sender:self];
        
    }
    else if ([cellText isEqualToString:badge]) {
        [self performSegueWithIdentifier:@"badgeTableViewController" sender:self];
    }
    else if ([cellText isEqualToString:addEmail]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:addEmail message:@"Associate Email to Push2Engage" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = addEmail;
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleDestructive handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (alertController.textFields.firstObject.text && alertController.textFields.firstObject.text.length) {
                if ([self validateEmailWithString:alertController.textFields.firstObject.text]) {
                    [Push setEmailID:alertController.textFields.firstObject.text];
                }
                else {
                    [self showError:@"Invalid Email ID"];
                }
            }
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if ([cellText isEqualToString:addAlias]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:addEmail message:@"Associate Alias to Push2Engage" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = addAlias;
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleDestructive handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (alertController.textFields.firstObject.text && alertController.textFields.firstObject.text.length) {
                [Push setAlias:alertController.textFields.firstObject.text];
            }
            else {
                [self showError:@"Invalid Alias"];
            }
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)showError:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok action") style:UIAlertActionStyleDestructive handler:nil];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
