//
//  BancoDados.m
//  CadastroUsuario
//
//  Created by Érika Tiemi Uehara Moriya on 3/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
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

-(PerfilUsuario *) criaUsuario: (NSString*) nomeUsuario
                    nascimento: (NSDate*) dataNasc
                    id_digital:(long int) digital{
    
    
    PerfilUsuario *usuario = [[PerfilUsuario alloc]init];
    usuario.nomePessoa = nomeUsuario;
    usuario.dataNascimento = dataNasc;
    usuario.id_digital = digital;
    //Para comparar os atributos tem que comparar um por um colocando-os no array ou usando o predicate
    // se forem vários atributos para comparar é melhor utilizar o predicate
    NSArray *names = [self.bancoDados valueForKey:@"nomePessoa"];
    
    
    if([names containsObject:nomeUsuario]){
        
        return nil;
    }
    else{
        
        [self.bancoDados addObject:usuario];
    }
    return usuario;
    
}

@end

