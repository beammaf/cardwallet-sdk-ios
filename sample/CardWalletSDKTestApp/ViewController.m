//
//  ViewController.m
//  CardWalletSDKTestApp
//
//  Created by Kagan Ozupek on 11.10.2018.
//  Copyright © 2018 Kagan Ozupek. All rights reserved.
//

#import "ViewController.h"
#import "CardWalletSDKTestApp-Swift.h"

@import CardWalletSDK;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<CreditCard *> *creditCards;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getCards];
}

- (void)getCards {
    
    [[HudManager shared] showHudWithController:self message:nil];
    
    [[CardWalletSDK shared] getCreditCardsWithSuccess:^(NSArray<CreditCard *> * _Nullable creditCards) {
        self.creditCards = [[NSMutableArray alloc] initWithArray:creditCards];
        [self.tableView reloadData];
        [[HudManager shared] dismissHud];
    } failure:^(CWError * _Nullable error) {
        [[HudManager shared] showHudWithController:self.navigationController message:[NSString stringWithFormat:@"ERROR:CODE : %ld\nMessage : %@",error.errorCode,error.errorDescription]];

        [[HudManager shared] dismissHud];

    }];
    
}

- (IBAction)CLAddCard:(id)sender {
    [self addCardWithoutCustomization];
}

-(IBAction)addCardWithCustomizationButtonPressed:(id)sender {
    /*[[CardWalletSDK shared] addCreditCardWithHostController:self.navigationController success:^(CreditCard * _Nullable creditCard) {

     } failure:^(CWError * _Nullable error) {

     }];
     */
    [self addCardWithCustomization];
}

- (void)addCardWithCustomization {
    [[CardWalletSDK shared] addCreditCardWithHostController:self.navigationController nibName:@"CustomAddCardController" bundle:[NSBundle mainBundle] success:^(CreditCard * _Nullable creditCard) {
        
//        [[self navigationController] popViewControllerAnimated:YES];
        
    } failure:^(CWError * _Nullable error) {
        NSLog(@"%@",[NSString stringWithFormat:@"ERROR:CODE : %ld\nMessage : %@",error.errorCode,error.errorDescription]);
        [[HudManager shared] showHudWithController:self.navigationController.topViewController message:[NSString stringWithFormat:@"ERROR:CODE : %ld\nMessage : %@",error.errorCode,error.errorDescription]];

    }];
}

- (void)addCardWithoutCustomization {
    
    [[CardWalletSDK shared] addCreditCardWithHostController:self.navigationController success:^(CreditCard * _Nullable creditCard) {
        
        [[CardWalletSDK shared] verifyCreditCardWithCardToken:creditCard.cardToken verifiedAmount:@"1.00" success:^(CreditCard * _Nullable creditCard) {
            
        } failure:^(CWError * _Nullable error) {
            [[HudManager shared] showHudWithController:self.navigationController.topViewController message:[NSString stringWithFormat:@"ERROR:CODE : %ld\nMessage : %@",error.errorCode,error.errorDescription]];

        }];
        
    } failure:^(CWError * _Nullable error) {
        NSLog(@"%@",[NSString stringWithFormat:@"ERROR:CODE : %ld\nMessage : %@",error.errorCode,error.errorDescription]);

        [[HudManager shared] showHudWithController:self.navigationController.topViewController message:[NSString stringWithFormat:@"ERROR:CODE : %ld\nMessage : %@",error.errorCode,error.errorDescription]];

    }];
    
}


#pragma mark UITableView DataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.creditCards.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fundingCellIdentifier" forIndexPath:indexPath];
    
    CreditCard *card = (CreditCard *)self.creditCards[indexPath.row];
    
    if(!card.requiresVerification){
        cell.textLabel.text = [NSString stringWithFormat:@"%@", card.cardNumber];
        cell.textLabel.textColor = [UIColor blackColor];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"NotVerified - %@", card.cardNumber];
        cell.textLabel.textColor = [UIColor redColor];

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteCard:indexPath];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CreditCard *card = self.creditCards[indexPath.row];
    if(card.requiresVerification){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        VerifyViewController * vc = (VerifyViewController *)[sb instantiateViewControllerWithIdentifier:@"Verify"];
        vc.card = card;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction * deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self deleteCard:indexPath];
    }];
    
    deleteAction.backgroundColor = UIColor.redColor;
    
    return @[deleteAction];
}

- (void)deleteCard:(NSIndexPath *)indexPath {
    
    CreditCard *card = self.creditCards[indexPath.row];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Delete %@",card.description] message:@"Unlinking your card means you won't be able to make payments with it. Are you sure you want to proceed?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *deleteCardAction = [UIAlertAction actionWithTitle:@"Yes, continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteFundingSource:indexPath];
    }];
    
    [alertController addAction:deleteCardAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)deleteFundingSource:(NSIndexPath *)indexPath {
    
    CreditCard *card = self.creditCards[indexPath.row];
    
    [self.tableView beginUpdates];
    [self.creditCards removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    
    [[HudManager shared] showHudWithController:self message:nil];

    [[CardWalletSDK shared] deleteCardWithCardToken:card.cardToken success:^(BOOL result) {
        NSLog(@"Card successfully removed");
        [[HudManager shared] dismissHud];
    } failure:^(CWError * _Nullable error) {
        [[HudManager shared] dismissHud];
        [[HudManager shared] showHudWithController:self.navigationController message:[NSString stringWithFormat:@"ERROR:CODE : %ld\nMessage : %@",error.errorCode,error.errorDescription]];

        NSLog(@"%@", [NSString stringWithFormat:@"Error occured when deleting the card %@", error]);
    }];
    

}

@end
