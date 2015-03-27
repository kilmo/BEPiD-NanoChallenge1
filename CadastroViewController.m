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
#import <UIKit/UIKit.h>

@interface CadastroViewController ()

@property ( nonatomic, strong ) IBOutlet UIScrollView *scrollView;
@property ( nonatomic, strong ) IBOutlet UIView       *viewFormulario;
@property ( nonatomic, strong ) IBOutlet UIView       *viewListaUsuarios;
@property ( nonatomic, strong ) IBOutlet UITableView  *usersTableView;
@property ( nonatomic, strong ) IBOutlet UITextField  *userName;
@property ( nonatomic, strong ) IBOutlet UITextField  *userID;

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
- (void)updateIDlabel: (long int)hash {
    NSLog( @"Updating label..." );
    NSString *labelText = [ NSString stringWithFormat: @"%lu", hash ];
//    self.idHash.text =  [ NSString stringWithFormat: @"%lu", hash ];
//    [ self.idHash  ] ];
    [ self.userID setText: labelText ];

    NSLog( @"Updated" );
    
}
//-------------------------------------------------------------------
- (IBAction)touchIDrequested:(id)sender{
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Touch ID Test to show Touch ID working in a custom app";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    NSLog( @"Success! Hash: %lu", myContext.hash );
                                    [ self updateIDlabel: myContext.hash ];
                                } else {
                                    NSLog( @"Nope!" );
                                }
                            }];
    } else {
    }
}
//-------------------------------------------------------------------
- (IBAction)adicionaUsuario{
    NSLog( @"Usuário: %@ adicionado.", self.userName.text );
    
    PerfilUsuario *p = [ [BancoDados sharedStore] criaUsuario: self.userName.text ];
    if( p == nil){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Usuario ja cadastrado" message:@"Por favor, cadastre outro usuario." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        
        [ self.usersTableView reloadData ];
        [ self.userName resignFirstResponder ];
    }
    
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [ textField resignFirstResponder ];
    return YES;
}
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-------------------------------------------------------------------

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
