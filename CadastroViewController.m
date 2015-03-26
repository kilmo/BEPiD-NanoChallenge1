//
//  CadastroViewController.m
//  CadastroUsuario
//
//  Created by Érika Tiemi Uehara Moriya on 3/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "CadastroViewController.h"
#import "BancoDados.h"
#import "PerfilUsuario.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface CadastroViewController ()

@property ( nonatomic, strong ) IBOutlet UIScrollView *scrollView;
@property ( nonatomic, strong ) IBOutlet UIView       *viewFormulario;
@property ( nonatomic, strong ) IBOutlet UIView       *viewListaUsuarios;
@property ( nonatomic, strong ) IBOutlet UITableView  *usersTableView;
@property ( nonatomic, weak   ) IBOutlet UITextField  *userName;
//@property ( nonatomic, assign ) IBAction
@property ( nonatomic, strong ) NSMutableArray        *userListArray;



@end

@implementation CadastroViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [ super initWithNibName: nibNameOrNil
                            bundle: nibBundleOrNil ];
    
    if ( self ){
        
        CGRect bigRect = self.view.bounds;
        bigRect.size.width *= 2.0;
        CGRect screenRect = self.view.bounds;
        CGPoint trans;
        trans.x = self.view.bounds.size.width;
        
        //self.viewFormulario = [ [UIView alloc] initWithFrame: bigRect ];
        
        //self.scrollView = [ [UIScrollView alloc] init ];
        self.scrollView.pagingEnabled = YES;
        
      //  self.viewListaUsuarios.window.frame.origin.x += 100;
        
        [ self.scrollView addSubview: self.viewFormulario ];
        screenRect.origin.x += screenRect.size.width;
        
        self.viewListaUsuarios.frame = screenRect;
        [ self.scrollView addSubview: self.viewListaUsuarios ];
        
        self.scrollView.contentSize = bigRect.size;
        
    }
        
    return self;
    
}

//Parte Felipe

//-------------------------------------------------------------------
- (IBAction)authenticateButtonTapped:(id)sender {
    LAContext *context = [ [LAContext alloc] init];
    
    NSError *error = nil;
    
    if ( [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error] ){
        NSLog( @"User authenticated!");
    }
    else {
        NSLog( @"User NOT authenticated!");
        
    }
}
//-------------------------------------------------------------------
- (IBAction)adicionaUsuario{
    NSLog( @"Usuário: %@ adicionado.", self.userName.text );
    
    [ [BancoDados sharedStore] criaUsuario: self.userName.text ];
    [ self.usersTableView reloadData ];
    
}
//-------------------------------------------------------------------
- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger c = [ [[BancoDados sharedStore] listaNomes] count ];
    
    NSLog( @"table item count: %ld", c );
    return c;
}
//-------------------------------------------------------------------
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 1;
//}
//-------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog( @"Creating cells..." );
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"UITableViewCell"];
    
    NSArray *bDados = [ [BancoDados sharedStore] listaNomes ];
    PerfilUsuario *usuario = bDados[ indexPath.row ];
    
    if ( cell == nil ){
        cell = [ [UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                       reuseIdentifier: @"UITableViewCell"];
    }
    
    cell.textLabel.text = usuario.nomePessoa;
    
    return cell;
}
//-------------------------------------------------------------------
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog( @"Oka!" );
//
//    // Create an instance of UITableViewCell, with default appearance
//    UITableViewCell *cell = [ [UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
//                                                    reuseIdentifier: @"UITableViewCell" ];
//
//    // Set the text on the cell with the description of the item
//    // that is at the nth index of items, where n = row this cell
//    // will appear in on the tableview
//    NSArray *items = [ [BNRItemStore sharedStore] allItems ];
//    BNRItem *item = items[ indexPath.row ];
//
//    cell.textLabel.text = [ item description ];
//
//    return cell;
//}
//-------------------------------------------------------------------






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
