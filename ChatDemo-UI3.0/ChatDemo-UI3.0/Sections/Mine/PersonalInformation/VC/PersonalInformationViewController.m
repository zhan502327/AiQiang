//
//  PersonalInformationViewController.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/17.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "AddressChoicePickerView.h"

@interface PersonalInformationViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (weak, nonatomic) IBOutlet UILabel *aiqiangNumber;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *area;
@property (weak, nonatomic) IBOutlet UIImageView *erWeiMaImage;

@end

@implementation PersonalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 26, 40)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backButton]];
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", www, User_Heading]]];
    _nickname.text = User_NickName;
    
    [self setupForDismissKeyboard];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void)back:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 换头像
- (IBAction)changeHeadImageAction:(id)sender {
    [_nickname resignFirstResponder];

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择文件来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"本地相册", nil];
    [sheet showInView:self.view];
}

#pragma mark - 性别
- (IBAction)genderAction:(id)sender {
    [_nickname resignFirstResponder];
    AddressChoicePickerView *addressPickerView = [[AddressChoicePickerView alloc] init];
    addressPickerView.genderOrAdress = 1;
    addressPickerView.genderblock = ^(AddressChoicePickerView *view, UIButton *btn, AreaObject *locate){
        self->_gender.text = [NSString stringWithFormat:@"%@", locate.gender];
    };
    [addressPickerView show];
}

#pragma mark - 地区
- (IBAction)areaAction:(id)sender {
    [_nickname resignFirstResponder];
    AddressChoicePickerView *addressPickerView = [[AddressChoicePickerView alloc] init];
    addressPickerView.genderOrAdress = 0;
    addressPickerView.adressblock = ^(AddressChoicePickerView *view, UIButton *btn, AreaObject *locate){
        self->_area.text = [NSString stringWithFormat:@"%@", locate];
    };
    [addressPickerView show];
}

#pragma mark - 我的二维码
- (IBAction)erWeiMaAction:(id)sender {
    [_nickname resignFirstResponder];
    
    NSLog(@"我的二维码");
}

#pragma mark - 确认修改
- (IBAction)confirmAction:(id)sender {
    [_nickname resignFirstResponder];
    NSLog(@"确认修改");
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_nickname resignFirstResponder];
    return YES;
    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.navigationBar.barTintColor = [UIColor colorWithRed:0.900 green:0.216 blue:0.205 alpha:1.000];
    imagePicker.navigationBar.tintColor = [UIColor whiteColor];
    [imagePicker.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor whiteColor]}];
    switch (buttonIndex) {
        case 0://照相机
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1://本地相簿
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    _headImage.image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //网络请求
    [[NetworkManager new] networkWithURL:[NSString stringWithFormat:@"%@/api.php/User/changeHeadimg", www] pic:[info objectForKey:@"UIImagePickerControllerEditedImage"] parameter:@{@"uid": User_ID} success:^(id obj) {
        
    } fail:^(NSError *error) {
        
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
