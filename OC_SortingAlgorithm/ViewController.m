//
//  ViewController.m
//  OC_SortingAlgorithm
//
//  Created by andson-zhw on 16/8/11.
//  Copyright © 2016年 andson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *selectSortBtn;
@property (weak, nonatomic) IBOutlet UIButton *insertSortBtn;
@property (weak, nonatomic) IBOutlet UIButton *shellSortBtn;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
@property (weak, nonatomic) IBOutlet UITextView *methodDesTextView;
@property (nonatomic,assign)double  count;//运算次数
@property (weak, nonatomic) IBOutlet UIButton *calculateCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //简单的排序算法有三种：
    //1:选择排序算法
    //2:插入排序算法
    //3:希尔排序算法
    //4:冒泡排序算法
    
    
}
- (IBAction)calculated:(UIButton *)sender {
    [sender setTitle:[NSString stringWithFormat:@"%.f",_count] forState:UIControlStateNormal];
}

#pragma mark - 选择排序算法
- (IBAction)selectSort:(UIButton *)sender {
    //排序算法思路
     _count = 0;
    [_calculateCount setTitle:@"交换次数" forState:UIControlStateNormal];
    self.resultTextView.text = @"排序结果:";
    self.methodDesTextView.text = @"算法简介:\n关键点是拿到当前数组的最小的元素跟剩下的元素依次比较\n拿到首个元素，将这个元素的值作为首次遍历时的数组元素的最小值，它的下标记作最小元素的下标\n然后开始从0遍历整个数组，这个最小值跟数组里面的所有值进行比较\n如果在遍历过程中有数组元素的值有比当前记录的最小值,那么就需要变更之前记录的最小值，以及最小值元素的下标\n然后讲当前遍历的首个元素跟记录的最小元素，交换一下位置，如果反复就可以达到排序的效果\n特点：不会因是否有序数组而改变排序计算次数";
    NSArray *array = @[@(13),@(5),@(9),@(12),@(10),@(4),@(1),@(7)];//无序
//    NSArray *array =@[@(1),@(5),@(9),@(12),@(10),@(4),@(7),@(13)];//部分有序
    array = [self selectSort:[array mutableCopy] withStartIndex:0];
    

}

-(NSMutableArray *)selectSort:(NSMutableArray *)array withStartIndex:(int)start{
    if (start == array.count) {
        return array;
    }
    int minVale = [array[start] intValue];
    int minIndex = start;
    for (int index = start; index < array.count; index++) {
        if (minVale > [array[index] intValue]) {
            minVale = [array[index] intValue];
            minIndex = index;
            _count ++;
        }
    }
    
    [array exchangeObjectAtIndex:start withObjectAtIndex:minIndex];
    self.resultTextView.text = [self.resultTextView.text stringByAppendingString:[NSString stringWithFormat:@"\nstart:%d--end:%ld--count:%.f:%@",start,array.count,_count,array]];
    array = [self selectSort:array withStartIndex:start + 1];
    return array;
}



#pragma mark - 插入排序算法
- (IBAction)insertSort:(UIButton *)sender {
     _count = 0;
    [_calculateCount setTitle:@"交换次数" forState:UIControlStateNormal];
    self.resultTextView.text = @"排序结果:";
    self.methodDesTextView.text = @"算法简介:\n始终定义第一个元素为有序的，将元素逐个插入到有序排列之中\n其特点是要不断的移动数据，空出一个适当的位置，把待插入的元素放到里面去\n特点：对于有序数组或部分有序数组，此排序方法是十分高效的\n若果最小的元素都在最后部分的位置，那么该排序方法就会变得非常费劲了";
    NSArray *array =@[@(13),@(5),@(9),@(12),@(10),@(4),@(1),@(7)];//无序
//    NSArray *array =@[@(1),@(5),@(9),@(12),@(10),@(4),@(7),@(13)];//部分有序
    array = [self insertSortArray:[array mutableCopy]];
}

-(NSMutableArray *)insertSortArray:(NSMutableArray *)array{
    for (int i = 1; i < array.count; i ++) {
        int temp = [array[i] intValue];
        int j = i;
        for (; j > 0 && temp < [array[j -1] intValue]; j --) {
            array[j] =  array[j - 1];
            _count ++;
            
        }
        array[j] = @(temp);
        self.resultTextView.text = [self.resultTextView.text stringByAppendingString:[NSString stringWithFormat:@"\nstart-%d--count:%.f:%@",i,_count,array]];
        
        
    }
    
    return array;
}

#pragma mark - 希尔排序算法
- (IBAction)shellSort:(UIButton *)sender {
    _count = 0;
    [_calculateCount setTitle:@"交换次数" forState:UIControlStateNormal];
    self.resultTextView.text = @"排序结果:";
    self.methodDesTextView.text = @"算法简介:\n希尔排序是直接插入排序算法的一种更高效的改进版本\n使数组中任意间隔为N的元素都是有序的,这样的数组为N有序数组。N有序数组可以看作是N个小的有序数组所构成的一个数组\n记录按下标的一定增量分组，对每组使用直接插入排序算法排序；随着增量逐渐减少，每组包含的关键词越来越多，当增量减至1时，整个文件恰被分成一组，算法便终止\n特点：性能上比选择排序和插入排序快得多,中等大小规模表现良好，对规模非常大的数据排序不是最优选择";
    NSArray *array =@[@(13),@(5),@(9),@(12),@(10),@(4),@(1),@(7)];//无序
//    NSArray *array =@[@(1),@(5),@(9),@(12),@(10),@(4),@(7),@(13)];//部分有序
    [self shellSortArray:[array mutableCopy] withGapH:(int)array.count/2];
}

-(NSMutableArray *)shellSortArray:(NSMutableArray *)array withGapH:(int)gapH {
    
    if (gapH < 1 ) {
       return array;
    }else{
        for (int i = gapH; i < (int)array.count; i++ ) {
            int temp = [array[i] intValue];
            int j = i;
            while (j >= gapH && temp < [array[j - gapH] intValue]) {
                [self exchangeArray:array withNIndex:j andMIndex:j - gapH];
                j -= gapH;
                _count ++;
            }
            array[j] = @(temp);
            
        }
        self.resultTextView.text = [self.resultTextView.text stringByAppendingString:[NSString stringWithFormat:@"\nsortgapH-%d--count:%.f:%@",gapH,_count,array]];
        gapH = gapH/2;
        [self shellSortArray:array withGapH:gapH];
    }
    
    return array;
}

//交换两个元素
-(void)exchangeArray:(NSMutableArray *)array withNIndex:(int)n andMIndex:(int)m{
    int temp = [array[n] intValue];
    array[n] = array[m];
    array[m] = @(temp);
}


#pragma mark - 冒泡排序算法

//-(NSMutableArray *)bubbleSortArray:(NSMutableArray *)array{
//    
//    for (int j = 0; j < (int)array.count; j ++) {
//        for (int i = 0; i < (int)array.count - j - 1; j ++) {
//            int value1 = [array[i] intValue];
//            int value2 = [array[i+1] intValue];
//            if (value1 > value2) {
//                [self exchangeArray:array withNIndex:i andMIndex:i+1];
//                _count ++;
//            }
//            self.resultTextView.text = [self.resultTextView.text stringByAppendingString:[NSString stringWithFormat:@"\nsortstart-%d--count:%.f:%@",i,_count,array]];
//            
//        }
//    }
//    
//    return array;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
