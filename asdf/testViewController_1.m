//
//  testViewController_1.m
//  asdf
//
//  Created by apple on 15/4/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "testViewController_1.h"
#import "UIImage+ImageEffects.h"
#include <sys/param.h>
#include <sys/mount.h>

@interface testViewController_1 ()
- (IBAction)testBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lable;

@end

@implementation testViewController_1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)testBtn:(id)sender {
//    NSLog(@"%@",[self freeDiskSpaceInBytes]);
    NSString *str1 = @"阿克苏结果发空间发牢骚减肥啦This is a test.\nWill I pass?\n日本語のもじもあるEnglish\nEnglish y Español我´¨fladsjfla看哈角色包括发挥吧上看到 v 发挥吧热我国开发 v 阿克苏觉得 v 就啊规划 v 反抗精神的";
    NSString *str2 = @"AA啊耳环广大海外私人推荐我看rsukduytl";
    NSString *str3 = @"阿萨德发恶我发的发尾丰富啊锕锕锕发awef";
    NSString *str4 = @"阿萨德法规库后噢噢；阿让；l";
    self.lable.text = [self freeDiskSpaceInBytes];
    UILabel *intro = [[UILabel alloc]init];
    intro.numberOfLines = 0;
    NSString *introText = [NSString stringWithFormat:@"作者:%@\n 出版社:%@\n ISBN:%d\n 分类:%@\n 定价/页码:%@/%d页",@"asdfasdf", str1, 1234124 ,str3,str4,str2 ];
    NSMutableDictionary *attribute_2 = [NSMutableDictionary dictionary];
    NSMutableAttributedString *strtitle_2 = [[NSMutableAttributedString alloc]initWithString:introText attributes:attribute_2];
    NSMutableParagraphStyle *paragraphStyle_2 = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle_2 setLineSpacing:15];
    [paragraphStyle_2 setAlignment:NSTextAlignmentLeft];
//    [paragraphStyle_2 setMaximumLineHeight:7];
//    [paragraphStyle_2 setMinimumLineHeight:7];
//    [paragraphStyle_2 setHeadIndent:40];
//    [paragraphStyle_2 setTailIndent:0];
//    [paragraphStyle_2 setParagraphSpacingBefore:0];
//    [paragraphStyle_2 setParagraphSpacing:0];
//    [paragraphStyle_2 setFirstLineHeadIndent:10];
    
    /*
    CGFloat lineSpacing;
    CGFloat paragraphSpacing;
    NSTextAlignment alignment;
    CGFloat firstLineHeadIndent;
    CGFloat headIndent;
    CGFloat tailIndent;
    NSLineBreakMode lineBreakMode;
    CGFloat minimumLineHeight;
    CGFloat maximumLineHeight;
    NSWritingDirection baseWritingDir
    CGFloat lineHeightMultiple;
    CGFloat paragraphSpacingBefore;
    float hyphenationFactor;
    */
    [attribute_2 setObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    [attribute_2 setObject:paragraphStyle_2 forKey:NSParagraphStyleAttributeName];
    [strtitle_2 addAttributes:attribute_2 range:NSMakeRange(0, introText.length)];
    
    
    intro.attributedText = strtitle_2;
    CGSize retSize_2 = [introText boundingRectWithSize:(CGSize){self.view.frame.size.width,0}
                                               options:
                        NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading
                                            attributes:attribute_2
                                               context:nil].size;
    intro.frame = (CGRect){0,64,retSize_2};
    [self.view addSubview:intro];
    
    
    
    UIImage *image = [UIImage imageNamed:@"book2.jpg"];
    UIImage *image_1 = [image applyTintEffectWithColor:[UIColor whiteColor]];
    UIImage *image_2 = [image applyExtraLightEffect];
    UIImage *image_3 = [image applyLightEffect];
    UIImage *image_4 = [image applyBlurWithRadius:1.0 tintColor:[UIColor whiteColor] saturationDeltaFactor:1.0 maskImage:nil];
    UIImage *image_5 = [image applyBlurWithRadius:0.5 tintColor:[UIColor whiteColor] saturationDeltaFactor:0.5 maskImage:nil];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image_2];
    [imageView setFrame:(CGRect){0,300,200,200}];
    [self.view addSubview:imageView];
    
    
}

/**
 *  #include <sys/param.h>
 *  #include <sys/mount.h>
 */
-(NSString *) freeDiskSpaceInBytes{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return [NSString stringWithFormat:@"手机剩余存储空间为：%qi MB" ,freespace/1024/1024];
}
@end
