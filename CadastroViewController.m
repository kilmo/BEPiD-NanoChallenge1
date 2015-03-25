//
//  CadastroViewController.m
//  CadastroUsuario
//
//  Created by Érika Tiemi Uehara Moriya on 3/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "CadastroViewController.h"

@interface CadastroViewController ()

@property ( nonatomic, strong ) IBOutlet UIScrollView *scrollView;
@property ( nonatomic, strong ) IBOutlet UIView       *viewFormulario;

@end

@implementation CadastroViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [ super initWithNibName: nibNameOrNil
                            bundle: nibBundleOrNil ];
    
    if ( self ){
        
        CGRect bigRect = self.view.bounds;
        bigRect.size.width *= 2.0;
        
        //self.viewFormulario = [ [UIView alloc] initWithFrame: bigRect ];
        
        //self.scrollView = [ [UIScrollView alloc] init ];
        self.scrollView.pagingEnabled = YES;
        [ self.scrollView addSubview: self.viewFormulario ];
        
        self.scrollView.contentSize = bigRect.size;
    }
        
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

@end
