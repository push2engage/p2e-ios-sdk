//
//  AddTagTableViewController.m
//  P2EPush
//
//  Created by Push2Engage on 05/03/16.
//  Copyright © 2016 Push2Engage. All rights reserved.
//

#import "AddTagTableViewController.h"
#import <P2EPush/P2E.h>

#define SCREENSIZE                              [UIScreen mainScreen].bounds.size

#define ADD_GENERIC_TAG                         @"Add Generic Tag"
#define ADD_GROUP_TAG                           @"Add Tag In Group"

static NSString *const addTag = @"Add Tag";
static NSString *const group = @"Group Name";
static NSString *const addTagInGroup = @"Add Tag in Group";


@interface AddTagTableViewController ()

@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation AddTagTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AddTagCell"];
    
    _dataArray = @[ADD_GENERIC_TAG,ADD_GROUP_TAG];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //self.navigationItem.hidesBackButton = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

///*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddTagCell" forIndexPath:indexPath];
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    // Configure the cell...
    
    return cell;
}
//*/

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellText = [_dataArray objectAtIndex:indexPath.row];
    
    if ([cellText isEqualToString:ADD_GENERIC_TAG]) {
        //[self performSegueWithIdentifier:@"tagViewController" sender:self];
        ///*
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:addTag message:@"This tag will be added to user tag list" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = addTag;
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleDestructive handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (alertController.textFields.firstObject.text && alertController.textFields.firstObject.text.length) {
                [Push addTag:alertController.textFields.firstObject.text];
            }
            else {
                [self showError:@"Invalid Entry"];
            }
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        //*/
        
    }
    else if ([cellText isEqualToString:ADD_GROUP_TAG]) {
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
            else {
                [self showError:@"Invalid Entry"];
            }
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

- (void)showError:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok action") style:UIAlertActionStyleDestructive handler:nil];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
