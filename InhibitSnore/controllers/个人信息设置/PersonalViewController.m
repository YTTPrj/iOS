//
//  PersonalViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/13.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalTableViewCell.h"
#import "HeadViewController.h"
#import "WWSideslipViewController.h"
#import "MainViewController.h"
#import "HeadViewController.h"
#import "NMainViewController.h"
#import "MainViewController.h"
#import "MyCustomView.h"

@interface PersonalViewController (){
    NSArray * _nTmpArray;
    NSArray * _dTmpArray;
    UIImagePickerController * _imagePickerController;
    UIPickerView * _agePickerView;
    UIPickerView * _heightPickerView;
    UIPickerView * _weightPickerView;
    MyCustomView * myView;
//    UIPickerView * agePickerView;
    NSMutableArray * ageArray;
//    UIPickerView * heightPickerView;
    NSMutableArray * heightArray;
//    UIPickerView * weightPickerView;
    NSMutableArray * weightArray;
    UIPickerView * pickerView;
    NSMutableArray * pickerArray;
    //弹窗标题
    NSArray * setTitleArray;
    
    NSInteger tmpNum;
    
    NSInteger tmpRow;
}

@end

@implementation PersonalViewController

- (id)init
{
    self = [super init];
    if (self) {
//        self.ageStr = @"20岁";
//        self.heightStr = @"170cm";
//        self.weightStr = @"70kg";
        self.isMan = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    
    _cameraButton.imageView.layer.cornerRadius = 48;
    _cameraButton.imageView.layer.masksToBounds = YES;
    
    _cameraImageView.layer.cornerRadius = 48;
    _cameraImageView.layer.masksToBounds = YES;
    
    _textField.delegate = self;
    UITapGestureRecognizer * nameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameTap)];
    [_nameLabel addGestureRecognizer:nameTap];
    
    [self alterXIB];
    [self tableViewAlter];
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERNAME"];
    if (self.nameLabel.text.length==0) {
        self.nameLabel.text = @"请输入昵称";
        self.nameLabel.textColor = [UIColor lightGrayColor];
    }
    self.isMan = [[NSUserDefaults standardUserDefaults] boolForKey:@"ISMAN"];
    if (self.isMan==YES) {
        _manImageView.image = [UIImage imageNamed:@"男性图标选中"];
        _womanImageView.image = [UIImage imageNamed:@"女性图标"];
    }else{
        _manImageView.image = [UIImage imageNamed:@"男性图标"];
        _womanImageView.image = [UIImage imageNamed:@"女性图标选中状态"];
    }
    
    setTitleArray = @[@"设置年龄",@"设置身高",@"设置体重"];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"IMAGEDATA"]) {
        _cameraImageView.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"IMAGEDATA"]];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)nameTap
{
    NSLog(@"^^^^^^点了^^^^^");
    _textField.hidden=NO;
    [_textField becomeFirstResponder];
}

#pragma mark - textField代理
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"USERNAME"];
    _nameLabel.text = textField.text;
    _nameLabel.textColor = [UIColor blackColor];
    // [self.delegate myLayReciveName:_myName.text];
    if (self.nameLabel.text.length==0) {
        self.nameLabel.text = @"请输入昵称";
        self.nameLabel.textColor = [UIColor lightGrayColor];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    textField.hidden=YES;
    return YES;
}

- (void)alterXIB
{
   
    [_cameraButton setImage:[UIImage imageNamed:@"相机点击效果"] forState:UIControlStateHighlighted];
    _detailTableView.backgroundColor = [UIColor clearColor];
}

- (void)tableViewAlter
{
    
    _nTmpArray = @[@"性别",@"年龄",@"身高",@"体重"];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    _detailTableView.bounces = NO;
}

- (IBAction)sexChange:(UIButton *)sender {
    
}


#pragma mark - 拍照部分
- (IBAction)cameraClock:(UIButton *)sender {
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"选择本地图片", nil];

    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self takePhoto];
    } else if (buttonIndex==2){
        [self selectPhoto];
    }
}

- (void)takePhoto
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController.allowsEditing = YES;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

- (void)selectPhoto
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //设置选择后的图片可被编辑
    _imagePickerController.allowsEditing = YES;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
        //当选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            //先把图片转成NSData
            UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            UIImageWriteToSavedPhotosAlbum(image,self,nil,nil);
            //关闭相册界面
            [picker dismissViewControllerAnimated:YES completion:nil];
            //创建一个选择后图片的小图标放在下方
            //类似微薄选择图后的效果
            NSData * imageData = [[NSData alloc] init];
            imageData = UIImageJPEGRepresentation(image, 1);
            [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"IMAGEDATA"];
            _cameraImageView.image = image;
//            self.tag.pothoimage=image;
            //[self.delegate myLayReciveHead:_myHeader];
        }
    } else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];//根据info的UIImagePickerControllerEditedImage对应值取出image
        NSData * imageData = [[NSData alloc] init];
        imageData = UIImageJPEGRepresentation(image, 1);
        [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"IMAGEDATA"];
        _cameraImageView.image = image;
//        self.tag.pothoimage=image;
        //[self.delegate myLayReciveHead:_myHeader];
        [picker dismissViewControllerAnimated:YES completion:nil];//将图片拾取器移除
        
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark tableView-delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PersonalTableViewCell" owner:self options:nil][0];
    }
//    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.nameLabel.text = _nTmpArray[indexPath.row];
    if (indexPath.row==1) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"USERAGE"]==nil) {
            cell.dataLabel.text = @"请选择年龄";
            cell.dataLabel.textColor = [UIColor lightGrayColor];
        } else {
            cell.dataLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERAGE"];
            cell.dataLabel.textColor = [UIColor blackColor];
        }
    }
    if (indexPath.row==2) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"USERHEIGHT"]==nil) {
            cell.dataLabel.text = @"请选择身高";
            cell.dataLabel.textColor = [UIColor lightGrayColor];
        } else {
            cell.dataLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERHEIGHT"];
            cell.dataLabel.textColor = [UIColor blackColor];
        }
    }
    if (indexPath.row==3) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"USERWEIGHT"]==nil) {
            cell.dataLabel.text = @"请选择体重";
            cell.dataLabel.textColor = [UIColor lightGrayColor];
        } else {
            cell.dataLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERWEIGHT"];
            cell.dataLabel.textColor = [UIColor blackColor];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        if (self.isMan==YES) {
            self.isMan=NO;
        }else if (self.isMan==NO) {
            self.isMan=YES;
        }
        if (self.isMan==YES) {
            _manImageView.image = [UIImage imageNamed:@"男性图标选中"];
            _womanImageView.image = [UIImage imageNamed:@"女性图标"];
            [[NSUserDefaults standardUserDefaults] setBool:self.isMan forKey:@"ISMAN"];
            [[NSUserDefaults standardUserDefaults] setObject:@"男" forKey:@"USERSEX"];
        }else{
            _manImageView.image = [UIImage imageNamed:@"男性图标"];
            _womanImageView.image = [UIImage imageNamed:@"女性图标选中状态"];
            [[NSUserDefaults standardUserDefaults] setBool:self.isMan forKey:@"ISMAN"];
            [[NSUserDefaults standardUserDefaults] setObject:@"女" forKey:@"USERSEX"];
        }
        
    }else{
        myView = [[MyCustomView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) height:250 title:setTitleArray[indexPath.row-1]];
        [self agePickerView];
        if (indexPath.row==1) {
            tmpNum=1;
            [pickerView selectRow:[[NSUserDefaults standardUserDefaults] integerForKey:@"USERAGENUM"] inComponent:0 animated:YES];
        } else if (indexPath.row==2){
            tmpNum=2;
            [pickerView selectRow:[[NSUserDefaults standardUserDefaults] integerForKey:@"USERHEIGHTNUM"] inComponent:0 animated:YES];
        } else if (indexPath.row==3){
            tmpNum=3;
            [pickerView selectRow:[[NSUserDefaults standardUserDefaults] integerForKey:@"USERWEIGHTNUM"] inComponent:0 animated:YES];
        }
        [myView addSubview:pickerView];
        [myView.doneButton addTarget:self action:@selector(doneOnClickFromAge) forControlEvents:UIControlEventTouchUpInside];
        [myView.cancelButton addTarget:self action:@selector(cancelOnClickFromAge) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:myView];
    }
    [tableView reloadData];
}

#pragma mark -  pickerView
- (void)agePickerView
{
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-90, SCREENHEIGHT/2-81, 180, 100)];
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    ageArray = [[NSMutableArray alloc] init];
    heightArray = [[NSMutableArray alloc] init];
    weightArray = [[NSMutableArray alloc] init];
    for (int i=10; i<=100;i++) {
        [ageArray addObject:[NSString stringWithFormat:@"%d岁",i]];
    }
    for (int i=150; i<=300; i++) {
        [heightArray addObject:[NSString stringWithFormat:@"%dcm",i]];
    }
    for (int i=40; i<120; i++) {
        [weightArray addObject:[NSString stringWithFormat:@"%dkg",i]];
    }
}

#pragma mark - pickerView代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //返回每一列的行数
   
    if (tmpNum==1) {
         return ageArray.count;
    } else if (tmpNum==2){
        return heightArray.count;
    } else{
        return weightArray.count;
    }
}

//返回自定义视图
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    //设置文字
    if (tmpNum==1) {
        label.text = ageArray[row];
    } else if (tmpNum==2) {
        label.text = heightArray[row];
    } else {
        label.text = weightArray[row];
    }
    return label;
}

//返回某一列的宽度，凡是没设宽度的会被挤压
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 150;
}

//返回高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 25;
}

//选中了某一个行 滚动停止
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (tmpNum==1) {
        self.ageStr = ageArray[row];
        tmpRow=row;
    } if (tmpNum==2) {
        self.heightStr = heightArray[row];
        tmpRow=row;
    } if (tmpNum==3) {
        self.weightStr = weightArray[row];
        tmpRow=row;
    }
}

#pragma mark - 自定义视图事件
//年龄
- (void)doneOnClickFromAge
{
    if (tmpNum==1) {
        [[NSUserDefaults standardUserDefaults] setObject:self.ageStr forKey:@"USERAGE"];
        [[NSUserDefaults standardUserDefaults] setInteger:tmpRow forKey:@"USERAGENUM"];
    } else if (tmpNum==2) {
        [[NSUserDefaults standardUserDefaults] setObject:self.heightStr forKey:@"USERHEIGHT"];
        [[NSUserDefaults standardUserDefaults] setInteger:tmpRow forKey:@"USERHEIGHTNUM"];
    } else if (tmpNum==3) {
        [[NSUserDefaults standardUserDefaults] setObject:self.weightStr forKey:@"USERWEIGHT"];
        [[NSUserDefaults standardUserDefaults] setInteger:tmpRow forKey:@"USERWEIGHTNUM"];
    }
    [myView removeFromSuperview];
    [_detailTableView reloadData];
}
- (void)cancelOnClickFromAge
{
    [myView removeFromSuperview];
}






#pragma mark - 下一页
- (IBAction)nextPage:(UIButton *)sender {
    [self.view.superview setTransitionAnimationType:PSBTransitionAnimationTypeReveal toward:PSBTransitionAnimationTowardFromRight duration:0.5];
    
    HeadViewController * hvc = [[HeadViewController alloc] init];
    NMainViewController *nmvc = [[NMainViewController alloc] init];
    MainViewController * mvc = [[MainViewController alloc] init];
//    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:nmvc];
    WWSideslipViewController * wwvc = [[WWSideslipViewController alloc]initWithLeftView:hvc andMainView:mvc];
    [wwvc setSpeedf:0.5];
    wwvc.sideslipTapGes.enabled = YES;
    
    [self.navigationController pushViewController:wwvc animated:YES];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
