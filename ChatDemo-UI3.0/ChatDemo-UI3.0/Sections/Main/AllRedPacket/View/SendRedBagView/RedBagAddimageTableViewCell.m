//
//  RedBagAddimageTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/10.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RedBagAddimageTableViewCell.h"


#define IWFleaMarketAddMargin 8

#define GAP 10

@implementation RedBagAddimageTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    RedBagAddimageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell photos_view];
    [cell addimageButton];
    
    return cell;
}
#pragma mark - 懒加载视图

- (IWPhotosView *)photos_view{
    if (_photos_view == nil) {
        IWPhotosView *view = [[IWPhotosView alloc] init];
        view.userInteractionEnabled = YES;
        view.noClick = NO;
        [self.contentView addSubview:view];
        _photos_view = view;
    }
    return _photos_view;
}

- (UIButton *)addimageButton{
    if (_addimageButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundImage:[UIImage imageNamed:@"addphoto"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addimageButtonCkicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
        self.addimageButton = button;
    }
    return _addimageButton;
}

- (void)addimageButtonCkicked{
    if (_addimageButtonBlock) {
        _addimageButtonBlock();
    }
}

#pragma mark -数据处理



- (void)setPhotosArray:(NSArray *)photosArray{
    
    _photosArray = photosArray;
    
    NSInteger count = _photosArray.count;
    // 判断
    if (count == 6) {
        self.addimageButton.hidden = YES;
        self.photos_view.hidden = NO;
    } else if (count == 0) {
        self.addimageButton.hidden = NO;
        self.photos_view.hidden = YES;
    } else {
        self.addimageButton.hidden = NO;
        self.photos_view.hidden = NO;
    }
    
    self.photos_view.pic_urls = self.photosArray;
    
    CGFloat photosY = IWFleaMarketAddMargin;
    CGSize photosSize = [IWPhotosView sizeWithPhotosCount:_photos_view.pic_urls.count];
    CGFloat photosX = IWFleaMarketAddMargin;
    
    self.photos_view.frame = (CGRect){{photosX, photosY}, photosSize};
    
    if (count == 0 ) {
        self.addimageButton.frame = CGRectMake( GAP, GAP, 80, 80);
    }else if (count == 1 || count == 2){
        self.addimageButton.frame = CGRectMake(CGRectGetMaxX(self.photos_view.frame) + GAP, CGRectGetMinY(self.photos_view.frame), 80, 80);

    }else if (count == 3){
        self.addimageButton.frame = CGRectMake(CGRectGetMinX(self.photos_view.frame), CGRectGetMaxY(self.photos_view.frame) + GAP, 80, 80);
    }else if (count == 4){
        
        self.addimageButton.frame = CGRectMake(CGRectGetMinX(self.photos_view.frame) + 90, 100, 80, 80);
    }else if (count == 5){
        self.addimageButton.frame = CGRectMake(CGRectGetMinX(self.photos_view.frame) + 90 + 90, 100, 80, 80);

    }else{
        
    }

    

}
@end
