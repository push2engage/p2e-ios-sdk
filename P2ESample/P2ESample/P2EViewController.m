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

@interface P2EViewController ()

@property NSArray *dataArray;

@end

@implementation P2EViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    _dataArray = @[checkQuiteTime, enableQuiteTime, disableQuiteTime, addTag, addTagInGroup, removeTag, removeTagInGroup, updateBadgeCount, resetBadgeCount, incrementBadgeCount, decrementBadgeCount, sendLocation];
    
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
        
    }
    else if ([cellText isEqualToString:disableQuiteTime]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:disableQuiteTime message:@"Quite time disabled." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok action") style:UIAlertActionStyleDestructive handler:nil];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        [Push disableQuietTime];
    }
    else if ([cellText isEqualToString:addTag]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:addTag message:@"This tag will be added to user tag list" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = addTag;
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleDestructive handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (alertController.textFields.firstObject.text && alertController.textFields.firstObject.text.length) {
                [Push addTag:alertController.textFields.firstObject.text];
            }
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else if ([cellText isEqualToString:addTagInGroup]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:addTag message:@"This tag will be added to a group name" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = addTag;
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = group;
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleDestructive handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if ((alertController.textFields.firstObject.text && alertController.textFields.firstObject.text.length) &&
                (alertController.textFields.lastObject.text && alertController.textFields.lastObject.text.length)) {
                [Push addTag:alertController.textFields.firstObject.text inGroup:alertController.textFields.lastObject.text];
            }
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else if ([cellText isEqualToString:removeTag]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:removeTag message:@"This tag will be removed from user tag list" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = removeTag;
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleDestructive handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (alertController.textFields.firstObject.text && alertController.textFields.firstObject.text.length) {
                [Push removeTag:alertController.textFields.firstObject.text];
            }
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if ([cellText isEqualToString:removeTagInGroup]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:addTag message:@"This tag will be removed from a group name" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = removeTag;
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = group;
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleDestructive handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if ((alertController.textFields.firstObject.text && alertController.textFields.firstObject.text.length) &&
                (alertController.textFields.lastObject.text && alertController.textFields.lastObject.text.length)) {
                [Push removeTag:alertController.textFields.firstObject.text inGroup:alertController.textFields.lastObject.text];
            }
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if ([cellText isEqualToString:updateBadgeCount]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:updateBadgeCount message:@"Please update badge count" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleDestructive handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (alertController.textFields.firstObject.text && alertController.textFields.firstObject.text.length) {
                [Push updateBadgeCount:[alertController.textFields.firstObject.text integerValue]];
            }
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if ([cellText isEqualToString:resetBadgeCount]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:resetBadgeCount message:@"Badge has been reset." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok action") style:UIAlertActionStyleDestructive handler:nil];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        [Push resetBadgeCount];
    }
    else if ([cellText isEqualToString:incrementBadgeCount]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:incrementBadgeCount message:@"Badge has been incremented." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok action") style:UIAlertActionStyleDestructive handler:nil];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        [Push increaseBadgeCount];
    }
    else if ([cellText isEqualToString:decrementBadgeCount]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:decrementBadgeCount message:@"Badge has been decremented." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok action") style:UIAlertActionStyleDestructive handler:nil];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        [Push decreaseBadgeCount];
    }
    else if ([cellText isEqualToString:sendLocation]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:sendLocation message:@"Location sent to server" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok action") style:UIAlertActionStyleDestructive handler:nil];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        [Push sendLocation];
    }
}

@end
