//
//  QQViewController.h
//  QQ列表分组
//
//  Created by 韩军强 on 16/5/3.
//  Copyright © 2016年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

///可以展开合并的表格
@property (nonatomic, strong) UITableView *myTableView;
///表格的数据
@property(strong, nonatomic) NSMutableArray *allResultArray;


///记录点击的section
//（点击的section是第几个，转成字符串赋值给whichSection，再次点击的时候移除whichSection）
@property (strong, nonatomic) NSMutableArray *whichOpenArray;
///点击的是哪个section（0、1、2。。。）
@property (strong, nonatomic) NSString *whichSection;


@property (strong, nonatomic) NSString *sectionKey;//section数组的名字（name）
@property (strong, nonatomic) NSString *rowListKey;//获取row数组的key（country）
@property (strong, nonatomic) NSString *rowName;//row数组的名字 (cityName)

///点击section的方法。
-(void)tapAction:(UIButton *)sender;




@end
