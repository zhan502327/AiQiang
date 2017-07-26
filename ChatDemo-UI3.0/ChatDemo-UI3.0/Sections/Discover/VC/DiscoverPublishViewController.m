//
//  DiscoverPublishViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/28.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DiscoverPublishViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "DBTextView.h"
#import "IWPhotosView.h"
#import "UIView+Extension.h"
#import "DBPhotoModel.h"
#import "UzysAssetsPickerController.h"
#import "DiscoverTool.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "DBImageManger.h"

#define IWValue(value) ((value)/750.0f*[UIScreen mainScreen].bounds.size.width)
#define IWFleaMarketAddMargin 8
#define IWFleaMarketAddPadding 5
#define IWFleaMarketFieldHeight 34


@interface DiscoverPublishViewController ()<UITextViewDelegate,UzysAssetsPickerControllerDelegate>

@property (nonatomic, weak) TPKeyboardAvoidingScrollView *scroollView;
@property (nonatomic, weak) DBTextView *textView;
@property (nonatomic, weak) IWPhotosView *photosView;
@property (nonatomic, weak) UIView *addImageView;
@property (nonatomic, weak) UIButton *addImageButton;
@property (nonatomic, weak) UILabel *addImageText;
@property (nonatomic, weak) UIView *view3;
@property (nonatomic, strong) NSMutableArray *deleteImages;
@property (nonatomic, strong) NSMutableArray *images;
//@property (nonatomic, weak) UIView *view4;

@end

@implementation DiscoverPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
    [self setupscroollView];

    
    [self setupTextView];
    
    [self setupAddimageButton];

    [self addNotice];
}


- (void)setUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发布动态";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(publishDiscover)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)publishDiscover{
    
    if (self.textView.text.length == 0 && self.photosView.datas.count == 0) {
        [self showHint:@"请输入动态内容"];
        return;
    }
    
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:0];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //在这里写上放在全局队列的代码
        if (self.photosView.datas.count > 0) {
            for (int i = 0; i<self.photosView.datas.count; i++) {
                UIImage *image = [UIImage imageWithData:self.photosView.datas[i]];
                NSData *imageData =  [DBImageManger imageMangerWithImage:image andMaxSize:60];
                
                UIImage *after_image = [UIImage imageWithData:imageData];
                
                [imageArray addObject:after_image];
            }
        }
        
        [[NetworkManager new] networkWithURL:PublishDiscoverURL imageArray:imageArray parameter:@{@"uid":User_ID,@"content":self.textView.text} success:^(id obj) {
            [hud hide:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadDataAfterPublishDiscover" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } fail:^(NSError *error) {
        }];

        
        dispatch_async(dispatch_get_main_queue(), ^{
            //写在这里就是执行主函数的代码
//            [hud setHidden: YES];
        });
    });

}

- (void)addNotice {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(deleteImage:) name:IWImagesDeleteNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (NSMutableArray *)deleteImages {
    if (_deleteImages == nil) {
        _deleteImages = [NSMutableArray array];
    }
    return _deleteImages;
}

- (NSMutableArray *)images {
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)setupscroollView{
    if (_scroollView == nil) {
        TPKeyboardAvoidingScrollView *view = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 80);
        view.showsVerticalScrollIndicator = NO;
        view.scrollEnabled = YES;
        [self.view addSubview:view];
        _scroollView = (TPKeyboardAvoidingScrollView *)view;
    }
}

- (void)setupTextView{
    
    DBTextView *textview = [[DBTextView alloc] init];
    textview.frame = CGRectMake(10, 10, SCREEN_WIDTH-2*10, 80);
    textview.backgroundColor=[UIColor whiteColor];
    textview.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
    textview.delegate = self;
    textview.font = [UIFont systemFontOfSize:12];
    textview.placeholder = @"请填写要发表的动态~~";
    [self.scroollView addSubview:textview];
    self.textView =textview;
}


- (void)setupAddimageButton
{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame) + 10, SCREEN_WIDTH, 40);
    
    // photosView
    IWPhotosView *photosView = [[IWPhotosView alloc] init];
    photosView.noClick = NO;
    [view addSubview:photosView];
    self.photosView = photosView;
    
    UIView *addPictureView = [[UIView alloc] init];
    addPictureView.backgroundColor = [UIColor clearColor];
    addPictureView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    [view addSubview:addPictureView];
    self.addImageView = addPictureView;
    
    UIButton *button = [[UIButton alloc] init];
    button.width = 60;
    button.height = 40;
    button.y = 0;
    button.x = SCREEN_WIDTH - button.width - 2 * IWFleaMarketAddMargin;
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    button.backgroundColor = [UIColor clearColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"添加照片" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addPictureButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [addPictureView addSubview:button];
    self.addImageButton = button;
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentRight;
    label.text = @"(最多可添加6张)";
    label.textColor = [UIColor redColor];
    label.userInteractionEnabled = YES;
    CGFloat labelX = IWFleaMarketAddMargin;
    CGFloat labelY = 0;
    CGFloat labelW = button.x - IWFleaMarketAddMargin;
    CGFloat labelH = button.height;
    label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPictureButtonClicked)];
    [label addGestureRecognizer:gesture];
    
    [addPictureView addSubview:label];
    self.addImageText = label;
    
    [self.scroollView addSubview:view];
    self.view3 = view;
    
}

- (void)addPictureButtonClicked{
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionVideo = 0;
    picker.maximumNumberOfSelectionPhoto = 6 - self.images.count;
    [self presentViewController:picker animated:YES completion:^{
    }];
    
}


- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) {
        // Photo
        NSMutableArray *array = [NSMutableArray array];
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *asset = obj;
            DBPhotoModel *photo = [[DBPhotoModel alloc] init];
            photo.pic = asset.defaultRepresentation.url.absoluteString;
            photo.asset = asset;
            photo.showDelete = YES;
            [array addObject:photo];
            [self.images addObject:photo];
        }];

        [self setupImage];
    }
}

- (void)setupImage {
    NSInteger count = self.images.count;
    // 判断
    if (count == 6) {
        self.addImageView.hidden = YES;
        self.photosView.hidden = NO;
    } else if (count == 0) {
        self.addImageView.hidden = NO;
        self.photosView.hidden = YES;
        self.addImageText.text = @"添加图片(最多可添加6张)";
    } else {
        self.addImageView.hidden = NO;
        self.photosView.hidden = NO;
        self.addImageText.text = @"继续添加(最多可添加6张)";
    }
    
    self.photosView.pic_urls = self.images;
    
    CGFloat photosY = IWFleaMarketAddMargin;
    CGSize photosSize = [IWPhotosView sizeWithPhotosCount:_photosView.pic_urls.count];
    CGFloat photosX = IWFleaMarketAddMargin;
    
    self.photosView.frame = (CGRect){{photosX, photosY}, photosSize};
    // 设置尺寸
    [self resizeSize];
}

- (void)deleteImage:(NSNotification *)notification {
    NSString *url = notification.userInfo[IWImagesDeleteNotificationPic];
    NSMutableArray *tempImages = [NSMutableArray array];
    for (DBPhotoModel *photo in self.images) {
        if ([photo.pic isEqualToString:url]) {
            [self.deleteImages addObject:url];
        } else {
            [tempImages addObject:photo];
        }
    }
    self.images = tempImages;
    
    // 设置数据
    [self setupImage];
}

// 设置尺寸
- (void)resizeSize {
    if (self.addImageView.isHidden) {
        self.addImageView.y = -1000;
        self.view3.height = CGRectGetMaxY(self.photosView.frame)  + IWFleaMarketAddMargin;
    } else {
        self.addImageView.y = CGRectGetMaxY(self.photosView.frame) + IWFleaMarketAddMargin;
        self.view3.height = CGRectGetMaxY(self.addImageView.frame)  + IWFleaMarketAddMargin;
    }
//    self.view4.y = CGRectGetMaxY(self.view3.frame);
//    if (self.reports != nil) {
//        self.reportView.y = CGRectGetMaxY(self.view4.frame) - IWFleaMarketAddMargin;
//        self.submitButton.y = CGRectGetMaxY(self.reportView.frame) + 20;
//    } else {
//        self.submitButton.y = CGRectGetMaxY(self.view4.frame) + 20;
//    }
    self.scroollView.contentSize = CGSizeMake(self.scroollView.width, CGRectGetMaxY(self.addImageText.frame) + self.addImageText.frame.size.height + 84);
    
//    self.scroollView.contentSize = CGSizeMake(self.scroollView.width, CGRectGetMaxY(self.submitButton.frame) + self.submitButton.frame.size.height + 84);
}

@end
