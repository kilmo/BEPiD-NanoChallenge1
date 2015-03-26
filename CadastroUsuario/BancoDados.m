//
//  BancoDados.m
//  CadastroUsuario
//
//  Created by Érika Tiemi Uehara Moriya on 3/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BancoDados.h"
#import "PerfilUsuario.h"

@interface BancoDados()

@property (nonatomic, strong) NSMutableArray *bancoDados;

@end

@implementation BancoDados

+(instancetype) sharedStore{
    
    static BancoDados *sharedStore;
    
    if(!sharedStore){
        sharedStore = [[self alloc] initPrivate];
        
    }
    
    return sharedStore;
}

-(instancetype) init{
    [NSException raise:@"Singleton"
                format:@"Use + [BancoDados sharedStore]"];
    return nil;
}

-(instancetype) initPrivate{
    self = [super init];
    if(self){
        self.bancoDados = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSArray*) listaNomes{
    return [self.bancoDados copy];
}

-(PerfilUsuario *) criaUsuario: (NSString*) nomeUsuario{
    PerfilUsuario *usuario = [PerfilUsuario inserirUsuario: nomeUsuario];
    [self.bancoDados addObject:usuario];
    
    return usuario;
    
}






@end

