//
//  MyDataViewController.m
//  InhibitSnore
//
//  Created by FZY on 15/1/15.
//  Copyright (c) 2015年 FZY. All rights reserved.
//

#import "MyDataViewController.h"
#import "MyDataTableViewCell.h"
#import "MyCustomView.h"
#import "HeadViewController.h"

@interface MyDataViewController (){
    NSArray * tmpArray;
    UIImagePickerController * _imagePickerController;
    UIAlertView * _headAlertView;
    UIAlertView * _sexAlertView;
    UIAlertView * _nameAlertView;
    UITextField * _nameTextField;
    NSString * _tmpTextField;
    UIPickerView * pickerView;
    MyCustomView * myView;
    NSMutableArray * ageArray;
    NSMutableArray * heightArray;
    NSMutableArray * weightArray;
    NSInteger tmpNum;
    NSInteger tmpRow;
    NSArray * setTitleArray;
}

@end

@implementation MyDataViewController


- (void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"IMAGEDATA"]) {
        _headImageView.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults]objectForKey:@"IMAGEDATA"]];
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"USERSEX"]) {
        _sex = [[NSUserDefaults standardUserDefaults]objectForKey:@"USERSEX"];
    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    
    setTitleArray = @[@"设置年龄",@"设置身高",@"设置体重"];
    
    tmpArray = @[@"昵称",@"性别",@"年龄",@"身高",@"体重"];
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap)];
    [_headImageView addGestureRecognizer:tap];
    _headImageView.userInteractionEnabled = YES;
    
    
}

- (IBAction)lastPage:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)headTap
{
    _headAlertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"选择本地图片", nil];
    [_headAlertView show];
}

/*性别选择*/
- (void)selectSex
{
    _sexAlertView = [[UIAlertView alloc] initWithTitle:@"设置性别" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    [_sexAlertView show];
}

#pragma mark - alertView代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _headAlertView) {
        if (buttonIndex==1) {
            [self takePhoto];
        } else if (buttonIndex==2){
            [self selectPhoto];
        }
    }
    if (alertView==_sexAlertView) {
        if (buttonIndex==0) {
            [[NSUserDefaults standardUserDefaults] setObject:@"女" forKey:@"USERSEX"];
        } if (buttonIndex==1) {
            [[NSUserDefaults standardUserDefaults] setObject:@"男" forKey:@"USERSEX"];
        }
        [_tableView reloadData];
    }
//    if (alertView==_nameAlertView) {
//        if (buttonIndex==0) {
//            NSLog(@"^^^^没有改^^^^");
//        }if (buttonIndex==1) {
//            NSLog(@"^^^^已改了^^^^");
////            [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:@"USERNAME"];
//            NSLog(@"_tmpTextField^^^^^^^^^%@^^^",self.userName);
//        }
//        [_tableView reloadData];
//    }
    [_tableView reloadData];
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
            _headImageView.image = image;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ALTERPHOTO" object:nil];
        }
    } else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];//根据info的UIImagePickerControllerEditedImage对应值取出image
        NSData * imageData = [[NSData alloc] init];
        imageData = UIImageJPEGRepresentation(image, 1);
        [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"IMAGEDATA"];
        _headImageView.image = image;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ALTERPHOTO" object:nil];
        NSLog(@"^^^^^^%@^^^^^^",image);
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

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tmpArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MyDataTableViewCell" owner:self options:nil][0];
    }
    cell.titleLabel.text = tmpArray[indexPath.row];
    if (indexPath.row==0) {
        if (((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"USERNAME"]).length==0) {
            cell.InformationLabel.text = @"请输入昵称";
        } else {
            cell.InformationLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERNAME"];
        }
    } if (indexPath.row==1) {
        if (((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"USERSEX"]).length==0) {
            cell.InformationLabel.text = @"请选择性别";
        } else {
            cell.InformationLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERSEX"];
        }
    }if (indexPath.row==2) {
        if (((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"USERAGE"]).length==0) {
            cell.InformationLabel.text = @"请选择年龄";
        } else {
            cell.InformationLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERAGE"];
        }
    } if (indexPath.row==3) {
        if (((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"USERHEIGHT"]).length==0) {
            cell.InformationLabel.text = @"请选择身高";
        } else {
            cell.InformationLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERHEIGHT"];
        }
    } if (indexPath.row==4) {
        if (((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"USERWEIGHT"]).length==0) {
            cell.InformationLabel.text = @"请选择体重";
        } else {
            cell.InformationLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERWEIGHT"];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        _nameAlertView = [[UIAlertView alloc] initWithTitle:@"请输入昵称" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
        _nameAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        _nameTextField = [_nameAlertView textFieldAtIndex:0];
        _nameTextField.textAlignment = NSTextAlignmentCenter;
        _nameTextField.placeholder = @"请输入昵称";
        _nameTextField.delegate = self;
        
        [_nameAlertView show];
    } if (indexPath.row==1) {
        _sexAlertView = [[UIAlertView alloc] initWithTitle:@"请选择性别" message:nil delegate:self cancelButtonTitle:@"女" otherButtonTitles:@"男", nil];
        [_sexAlertView show];
    } else if (indexPath.row>1){
        myView = [[MyCustomView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) height:250 title:setTitleArray[indexPath.row-2]];
        [self agePickerView];
        if (indexPath.row==2) {
            tmpNum=1;
            [pickerView selectRow:[[NSUserDefaults standardUserDefaults] integerForKey:@"USERAGENUM"] inComponent:0 animated:YES];
        } else if (indexPath.row==3){
            tmpNum=2;
            [pickerView selectRow:[[NSUserDefaults standardUserDefaults] integerForKey:@"USERHEIGHTNUM"] inComponent:0 animated:YES];
        } else if (indexPath.row==4){
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

#pragma mark - 改名字的textField
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.userName = textField.text;
    [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:@"USERNAME"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ALTERNAME" object:nil];
}



//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:@"USERNAME"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ALTERNAME" object:nil];
//    return YES;
//}

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
    [_tableView reloadData];
}
- (void)cancelOnClickFromAge
{
    [myView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UINIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
