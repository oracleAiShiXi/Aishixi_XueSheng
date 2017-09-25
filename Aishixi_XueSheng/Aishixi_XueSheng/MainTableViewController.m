//
//  MainTableViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/18.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "MainTableViewController.h"
#import "maincellTableViewCell.h"
#import "AttendanceViewController.h"

#import "NoticeViewController.h"
#import "AdvisoryViewController.h"
#import "EditDiaryViewController.h"
#import "MySelfTableViewController.h"
#import "SetViewController.h"
@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 3;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    if(section==0){
//        return 2;
//    }else if (section==1){
//        return 1;
//    }else{
//        return 5;
//    }
//}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
////    
////    // Configure the cell...
////    
////    
////    return cell;
//    static NSString *reuseIdentifier = @"mycell";
//    
//        maincellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
//        
//        if (!cell) {
//            cell = [[maincellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
//        }
//        cell.TitleLabel.text=@"新学期暑假";
//        cell.TimeLabel.text =@"2017-10-11";
//        return cell;
//   
//}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Attendance:(id)sender {
    AttendanceViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Attendance"];
    [self.navigationController pushViewController:his animated:YES];
}

- (IBAction)Notice:(id)sender {
    NoticeViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"notice"];
    [self.navigationController pushViewController:his animated:YES];
    
}

- (IBAction)Advisory:(id)sender {
    AdvisoryViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Advisory"];
    [self.navigationController pushViewController:his animated:YES];
    
}

- (IBAction)Help:(id)sender {
}

- (IBAction)Appraise:(id)sender {
    
}

- (IBAction)Diary:(id)sender {
    EditDiaryViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EditDiary"];
    [self.navigationController pushViewController:his animated:YES];
}

- (IBAction)Myself:(id)sender {
    MySelfTableViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MySelf"];
    [self.navigationController pushViewController:his animated:YES];
}

- (IBAction)Set:(id)sender {
    SetViewController  *set = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Set"];
    [self.navigationController pushViewController:set animated:YES];
}
@end
