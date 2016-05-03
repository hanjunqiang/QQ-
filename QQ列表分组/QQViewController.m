//
//  QQViewController.m
//  QQ列表分组
//
//  Created by 韩军强 on 16/5/3.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "QQViewController.h"

#define kSectionHeaderHeight 50.0f

@interface QQViewController ()

@end

@implementation QQViewController

#pragma mark -只是初始化赋值罢了
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.whichOpenArray = [NSMutableArray array];
        self.sectionKey = [NSString stringWithFormat:@"name"];
        self.rowListKey = [NSString stringWithFormat:@"country"];
        self.rowName = [NSString stringWithFormat:@"cityName"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ///section1
    NSMutableDictionary *cityDict1 = [NSMutableDictionary dictionary];
    [cityDict1 setObject:@"北京" forKey:self.rowName];
    NSMutableDictionary *cityDict2 = [NSMutableDictionary dictionary];
    [cityDict2 setObject:@"上海" forKey:self.rowName];
    NSMutableDictionary *cityDict3 = [NSMutableDictionary dictionary];
    [cityDict3 setObject:@"广州" forKey:self.rowName];
    NSMutableDictionary *cityDict4 = [NSMutableDictionary dictionary];
    [cityDict4 setObject:@"郑州" forKey:self.rowName];
    
    NSMutableArray *country1 = [NSMutableArray arrayWithObjects:cityDict1,cityDict2,cityDict3,cityDict4, nil];
    NSMutableDictionary *countryDict1 = [NSMutableDictionary dictionaryWithObject:country1 forKey:self.rowListKey];
    [countryDict1 setObject:@"中国" forKey:self.sectionKey];
    
    //section2
    NSMutableDictionary *cityDict21 = [NSMutableDictionary dictionary];
    [cityDict21 setObject:@"华盛顿" forKey:self.rowName];
    NSMutableDictionary *cityDict22 = [NSMutableDictionary dictionary];
    [cityDict22 setObject:@"迈阿密" forKey:self.rowName];
    NSMutableDictionary *cityDict23 = [NSMutableDictionary dictionary];
    [cityDict23 setObject:@"波士顿" forKey:self.rowName];
    NSMutableDictionary *cityDict24 = [NSMutableDictionary dictionary];
    [cityDict24 setObject:@"费城" forKey:self.rowName];
    NSMutableArray *country2 = [NSMutableArray arrayWithObjects:cityDict21,cityDict22,cityDict23,cityDict24, nil];
    NSMutableDictionary *countryDict2 = [NSMutableDictionary dictionaryWithObject:country2 forKey:self.rowListKey];
    [countryDict2 setObject:@"美国" forKey:self.sectionKey];
    
    self.allResultArray = [NSMutableArray arrayWithObjects:countryDict1,countryDict2, nil];
    
    NSLog(@"所有的数据\n%@",self.allResultArray);
    
    //初始化myTableView
    if (self.myTableView==nil||self.myTableView==NULL) {
        self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStyleGrouped];
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self;
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.myTableView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:self.myTableView];
        if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
        }
    }
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allResultArray.count;  //数组里面装了几个字典就有几个部分
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int tempNum = (int)[[self.allResultArray[section]objectForKey:self.rowListKey] count];
    NSString *tempSectionString = [NSString stringWithFormat:@"%ld",(long)section];
    if ([self.whichOpenArray containsObject:tempSectionString]) {
        return tempNum;
    }
    return 0;
}

//去掉footView
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark -headView当做section
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *tempV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50)];
    tempV.backgroundColor = [UIColor colorWithRed:(236)/255.0f green:(236)/255.0f blue:(236)/255.0f alpha:1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(16, 2, 200, 30)];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont fontWithName:@"Arial" size:20];
    label1.text = [self.allResultArray[section] objectForKey:self.sectionKey];
    
    UIImageView *tempImageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50, 20, 20, 11)];
    NSString *tempSectionString = [NSString stringWithFormat:@"%ld",(long)section];
    if ([self.whichOpenArray containsObject:tempSectionString]) {
        tempImageV.image = [UIImage imageNamed:@"close"];
        
    }else{
        tempImageV.image = [UIImage imageNamed:@"open"];
    }
    ///给section加一条线。
    CALayer *_separatorL = [CALayer layer];
    _separatorL.frame = CGRectMake(0.0f, 49.0f, [UIScreen mainScreen].bounds.size.width, 1.0f);
    _separatorL.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    [tempV addSubview:label1];
    [tempV addSubview:tempImageV];
    [tempV.layer addSublayer:_separatorL];
    
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    [tempBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    tempBtn.tag = section;
    [tempV addSubview:tempBtn];
    return tempV;
}

#pragma mark -cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kSectionHeaderHeight;
}

#pragma mark -（点击的section是第几个，转成字符串赋值给whichSection，再次点击的时候移除whichSection）
-(void)tapAction:(UIButton *)sender{
    
    self.whichSection = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    if ([self.whichOpenArray containsObject:self.whichSection]) {
        [self.whichOpenArray removeObject:self.whichSection];
    }else{
        [self.whichOpenArray addObject:self.whichSection];
    }
    ///下面一句是用的时候刷新的。
        [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.contentView.backgroundColor = [UIColor yellowColor];
    cell.textLabel.text = [[[self.allResultArray[indexPath.section]objectForKey:self.rowListKey] objectAtIndex:indexPath.row] objectForKey:self.rowName];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        if (indexPath.row==1) {
            NSLog(@"1111");
        }
        
    }
}


@end
