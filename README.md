
#  CardWallet SDK - IOS Guide

The CardWallet SDK is for interacting with the funding platform to add, update or remove card. It provides functionality to manage credit cards.

In order to use SDK framework you must be a registered developer with a provisioned token.

## Requirements
* SDK Supports min IOS 11 or newer Deployment Target.
* CardWalletCredentialsProvider Protocol must be implemented for Credentials: Provided by development team.

## Integration
### CocoaPods
In order to add framework via cocoapods you need to add this pod to podfile
```
pod 'CardWalletSDK'
```
This will download required dependencies to project.
###  Manual

To install the CardWallet SDK directly into your application, open your project and open the project navigator (**⌘ + 0**) > Tap on **Your Project** > Under **Targets**, click on the selected **Build Target** > Tap on the **General** tab, located at the top > Drag the CardWalletSDK.framework into the **Embedded Frameworks** section. The CardWalletSDK.framework should appear in both the Embedded Frameworks and Linked Libraries and Frameworks section.

### Required Libraries

CardWalletSDK dependent a couple of another framework. Please make sure you have;

Moya.framework\
Result.framework\
RxCocoa.framework\
RxMoya.framework\
Alamofire.framework

inside the Embedded Frameworks section


# SDK Overview

## Initialize and Start Sdk
Use CardWalletSDK framework, import CardWalletSDK first, and then call CardWalletSDK's *start* function.


```swift
let builder = CardWalletSDKBuilder().setEnvironment(environment: Environment.STAGING).setCredentialsProvider(provider: self)
CardWalletSDK.start(builder: builder)
```

## CardWalletSDK Object

* All sdk functions using CardWalletSDK object. It's a simple object to access functionalities of CardWalletSDK. You can call these functions via CardWalletSDK's singleton.

```swift
/**
     Start the Funding for initial logic
     
     - Important: Don't forget the implementation CardWalletCredentialsProvider protocol for your valid access which is given by the Development Team.
     
     - Parameters:
     - CardWalletSDKBuilder: Builder includes CardWalletCredentialsProvider and Environment
     

     // Sample Implementation
     let builder = CardWalletSDKBuilder().setEnvironment(environment: Environment.STAGING).setCredentialsProvider(provider: self)
     CardWalletSDK.start(builder: builder)

     */
    @objc public static func start(builder : CardWalletSDKBuilder){
        if(instance == nil){
            instance = CardWalletSDK(builder: builder)
        }
    }
    
    
    /**
     Add your creditCard for your card management
     
     - Parameter hostController: Your initial navigationController that want open to use your add card controller
     - Parameter success: Returns the added card model
     - Parameter creditCard: Added card model
     - Parameter failure: Returns the error object that includes error logic
     - Parameter error: FSError object that includes error cause
     
     - throws: `FSError`
        - An error of type `FSError`
     
     */
    @objc public func addCreditCard(hostController : UINavigationController,
                                    success : @escaping (_ creditCard: CreditCard?) -> (),
                                    failure : @escaping (_ error: FSError?) -> ()){
       
        
        manager.addCreditCard(hostController: hostController, success: success, failure: failure)
    }
    
    /**
     Add your creditCard for your with your own xib file
     
     - precondition: In your own controller that supply xib file, you should set your views our tag numbers for integration
     
     - Parameter hostController: Your initial navigationController that want open to use your add card controller
     - Parameter nibName: Your custom xib name
     - Parameter bundle: Your bundle that where your xib file includes
     - Parameter success: Returns the added card model
     - Parameter creditCard: Added card model
     - Parameter failure: Returns the error object that includes error logic
     - Parameter error: FSError object that includes error cause
     
     - throws: `FSError`
        - An error of type `FSError`
     
     */
    @objc public func addCreditCard(hostController : UINavigationController,
                                    nibName : String,
                                    bundle : Bundle,
                                    success : @escaping (_ creditCard: CreditCard?) -> (),
                                    failure : @escaping (_ error: FSError?) -> ()){
        manager.addCreditCard(hostController: hostController,nibName : nibName, bundle : bundle, success: success, failure: failure)
    }
    
    /**
     After you added your creditCard, you should verify it for security purposes. Until that, you only will be able integrate up to a certan limit.
     
     - precondition: In your own controller that supply xib file, you should set your views our tag numbers for integration
     
     - Parameter success: Returns the verified card model
     - Parameter creditCard: Verified card model
     - Parameter failure: Returns the error object that includes error logic
     - Parameter error: FSError object that includes error cause
     
     - throws: `FSError`
     - An error of type `FSError`
     
     */
    @objc public func verifyCreditCard( creditCard : CreditCard,
                                        verifiedAmount : String,
                                        success : @escaping (_ creditCard: CreditCard?) -> (),
                                        failure : @escaping (_ error: FSError?) -> ()) {
        manager.verifyCreditCard(amount: verifiedAmount, cardToken: creditCard.cardToken, success: success, failure: failure)
    }
    
    @objc public func testLogin(username : String,pin : String,callback: @escaping (String) -> ()){
        let testeBeamerService = TESTBeamerService()
        let loginRequest = LoginRequest(email : username, pinCode : pin)
        testeBeamerService.login(loginRequest: loginRequest).subscribe(onNext: { (response) in
            callback((response.response?.dummyToken)!)

        }, onError: { (error) in
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    /**
     Get your all funding sources
     
     - Parameter success: Returns the added cards
     - Parameter creditCards: All cards that added before
     - Parameter failure: Returns the error object that includes error logic
     - Parameter error: FSError object that includes error cause
     
     - throws: `FSError`
     - An error of type `FSError`
     
     */
    @objc public func getCreditCards(success : @escaping (_ creditCards: [CreditCard]?) -> (),failure : @escaping (_ error: FSError?) -> ()) {
        
        manager.getFundingSources(success: { (CreditCards) in
            
            let creditCards = CreditCards?.map({ (fundingSource) -> CreditCard in
                
                let modelController = CreditCardModelController(fundingSource: fundingSource)
                return modelController.creditCard
            })
            
            success(creditCards)
             
        }) { (error) in
            failure(error)
        }
    }

    /**
     Remove your creditCard for your card management
     
     - Parameter cardId: Your card id that you want to remove
     - Parameter success: Called empty success closure if the card removed succesfully
     - Parameter failure: Returns the error object that includes error logic
     - Parameter error: FSError object that includes error cause
     
     - throws: `FSError`
     - An error of type `FSError`
     
     */
    @objc public func removeCard( cardId: String, success : @escaping () -> Void,failure : @escaping (_ error: FSError?) -> ()) {
        
        manager.removeFundingSource(cardToken: cardId, success: success, failure: failure)
    }
```
## Models

### CreditCard
```swift

/// Credit Card for the Funding
@objc public class CreditCard : NSObject {

    @objc public var cardToken = String!
    @objc public var cardNumber : String!
    @objc public var status : String!
    @objc public var requiresVerification : Bool = false
    @objc public var canSendNewVerification : Bool = true
    @objc public var verificationAttemptsLeft : NSInteger = 3
}

```

### CWError
```swift
 var errorCode : Int = -1
 var errorDescription : String = ""
 @objc public var cause : NSError
```


All functions related to this sdk returns CWError objects. This object has an errorCode.

#### Error Codes
```swift
    @objc public static let Unknown = -1
    @objc public static let Unauthorized = 1
    @objc public static let JsonParseError = 2
    @objc public static let InvalidExpirationMonth = 3
    @objc public static let InvalidExpirationYear = 4
    @objc public static let ExpiredCard = 5
    @objc public static let SchemeNotSupported = 6
    @objc public static let InvalidCardNumber = 7
    @objc public static let InvalidFirstName = 8
    @objc public static let InvalidLastName = 9
    @objc public static let InvalidCVC = 10
    @objc public static let ValidationAmountProcessingError = 11
    @objc public static let IcorrectVerificationAmount = 12
```


## UI Customization.
CardWallet SDK supports custom UI for AddCreditCard functionality.

### Add Credit Card Page
You can pass custom xib file with addCreditCard function. Xib file must have some specific tags that you can use while you are adding your card. Tags are mandatory for xib usage.

|  View Type   | Descriptionn             |Tag   |
| ------------ | ------------------------ |----- |
|  UIImageView      | Credit Card Type Image      |100104 |
|  SecureTextField | Credit Card Number Field   |100100 |
|  SecureTextField | Expiry Date Field                 |100101 |
|  SecureTextField | CVC Number                       |100102 |
|  SecureTextField | Name Surname                   |100103 |
|  UIButton            | Submit Button                     |100105 |

## Version
* 1.1
