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
#import "SimpleTableCell.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <UIKit/UIKit.h>

@interface CadastroViewController ()

@property ( nonatomic, strong ) IBOutlet UIScrollView *scrollView;
@property ( nonatomic, strong ) IBOutlet UIView       *viewFormulario;
@property ( nonatomic, strong ) IBOutlet UIView       *viewListaUsuarios;
@property ( nonatomic, strong ) IBOutlet UITableView  *usersTableView;
@property ( nonatomic, strong ) IBOutlet UITextField  *userName;
@property ( nonatomic, strong ) IBOutlet UITextField  *userID;
@property ( nonatomic, strong ) IBOutlet UIDatePicker *userBirthday;

@property ( nonatomic, weak ) IBOutlet UILabel *labelName;
@property ( nonatomic, weak ) IBOutlet UILabel *labelDate;
@property ( nonatomic, weak ) IBOutlet UILabel *labelUserID;
@property ( nonatomic, weak ) IBOutlet UIImageView *thumbnailView;


@property ( nonatomic, strong ) NSMutableArray *userListArray;
@property ( nonatomic, strong ) NSArray        *thumbnails;
@property ( nonatomic, strong ) LAContext      *myContext;
@property ( nonatomic         ) long int       LIuserID;

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *prepTimeLabel;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnailImageView;


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

//-------------------------------------------------------------------
- (void)updateIDlabel: (long int)hash {
    NSString *labelText = [ NSString stringWithFormat: @"%lu", hash ];
    NSLog( @"Updating label... hash: %@", labelText );
    
    [ self.userID resignFirstResponder ];
    [ self.userID setText: labelText ];

    NSLog( @"Updated" );
    
}
//-------------------------------------------------------------------
- (IBAction)touchIDrequested:(id)sender{
    self.myContext = [[LAContext alloc] init];
  //  long int deviceOwner = 200;
    self.LIuserID = 0;
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Touch ID Test to show Touch ID working in a custom app";
    
    if ([self.myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [self.myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    self.LIuserID = 200;
                                    NSLog( @"Success! Hash: %lu", self.LIuserID );
                                    
                                } else {
                                    NSLog( @"Nope!" );
                                    
                                    self.LIuserID = self.myContext.hash;
                                }
                                [ self updateIDlabel: self.LIuserID ];
                            }];
    } else {
        self.LIuserID = self.myContext.hash;
    }
    //self.labelUserID.text = [ NSString stringWithFormat: @"%lu", self.LIuserID ];
  //  self.LIuserID = deviceOwner;
}
//-------------------------------------------------------------------
- (IBAction)adicionaUsuario{
    NSLog( @"Usuário: %@ adicionado.", self.userName.text );
    
    PerfilUsuario *p =     [[BancoDados sharedStore] criaUsuario: self.userName.text
                                                      nascimento: self.userBirthday.date
                                                      id_digital: self.LIuserID];

    if( p == nil){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Usuario ja cadastrado" message:@"Por favor, cadastre outro usuario." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        
        [ self.usersTableView reloadData ];
        [ self.userName resignFirstResponder ];
        [ self.userName setText: @"" ];

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Usuário adicionado" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
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

//    static NSString *simpleTableIdentifier = @"SimpleTableCell";
//    
//    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    if (cell == nil)
//    {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner: self options:nil];
//        cell = [nib objectAtIndex:0];
//    }
//    
//    cell.nameLabel.text = @"NOME";
//   // cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
//    cell.prepTimeLabel.text = @"PREP TIME";
//    
//    return cell;
    
    NSLog( @"Creating cells..." );
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"SimpleTableCell"];
    
    NSArray *bDados = [ [BancoDados sharedStore] listaNomes ];
    
    PerfilUsuario *usuario = bDados[ indexPath.row ];
    
    if ( cell == nil ){
//        NSArray *nib= [ [NSBundle mainBundle] loadNibNamed: @"SimpleTableCell"
//                                                     owner: self
//                                                   options: nil ];
        
        //cell = [ nib objectAtIndex: 0 ];
        cell = [ [UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                       reuseIdentifier: @"SimpleTableCell"];
    }
    
    cell.textLabel.text = [ NSString stringWithFormat: @"%@   %lu   %@", usuario.nomePessoa, usuario.id_digital, usuario.dataNascimento ];
    //cell.labelDate.text = @"DATA";
    cell.imageView.image = [ UIImage imageNamed: [self.thumbnails objectAtIndex: (indexPath.row %(self.thumbnails.count))] ];
    NSLog( @"IMG[%lu]: %@", indexPath.row, [self.thumbnails objectAtIndex: (indexPath.row %(self.thumbnails.count))] );
    
    return cell;
}
//-------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.thumbnails = [ NSArray arrayWithObjects: @"angry_birds_cake.jpg", @"creme_brelee.jpg", @"egg_benedict.jpg", @"full_breakfast.jpg", nil ];
    NSLog( @"Setting thumbnails array..." );
}
//-------------------------------------------------------------------
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
