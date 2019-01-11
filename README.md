
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

## CredentialsProvider
This protocol has one function called getCredentials(). This function should be implemented on the class which has capability of receive authentication token and partner id. This function has one parameter called didCredentialsReceived(CardWalletCredentials).  You can call this function after a async call to backend to get token information. Before every request to CardWallet Service. This function is going to call by SDK in order to get credentials for request.

```swift
func getCredentials(didCredentialsReceived: ((CardWalletCredentials) -> ())?) {
         let crendentials CardWalletCredentials(token: "Bearer <<TOKEN>>", partnerId: "<<PARTNET_ID>>")
         didCredentialsReceived(credentials)
    }
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
    @objc public static func start(builder : CardWalletSDKBuilder)
    
    
    
    /**
     Add your creditCard for your card management
     
     - Parameter hostController: Your initial navigationController that want open to use your add card controller
     - Parameter success: Returns the added card model
     - Parameter creditCard: Added card model
     - Parameter failure: Returns the error object that includes error logic
     - Parameter error: CWError object that includes error cause
     
     - throws: `CWError`
        - An error of type `CWError`
     
     */
    @objc public func addCreditCard(hostController : UINavigationController,
                                    success : @escaping (_ creditCard: CreditCard?) -> (),
                                    failure : @escaping (_ error: CWError?) -> ())
                                    
    /**
     Add your creditCard for your with your own xib file
     
     - precondition: In your own controller that supply xib file, you should set your views our tag numbers for integration
     
     - Parameter hostController: Your initial navigationController that want open to use your add card controller
     - Parameter nibName: Your custom xib name
     - Parameter bundle: Your bundle that where your xib file includes
     - Parameter success: Returns the added card model
     - Parameter creditCard: Added card model
     - Parameter failure: Returns the error object that includes error logic
     - Parameter error: CWError object that includes error cause
     
     - throws: `CWError`
        - An error of type `CWError`
     
     */
    @objc public func addCreditCard(hostController : UINavigationController,
                                    nibName : String,
                                    bundle : Bundle,
                                    success : @escaping (_ creditCard: CreditCard?) -> (),
                                    failure : @escaping (_ error: CWError?) -> ())
                                    
    
    /**
     After you added your creditCard, you should verify it for security purposes. Until that, you only will be able integrate up to a certan limit.
     
     - precondition: In your own controller that supply xib file, you should set your views our tag numbers for integration
     
     - Parameter success: Returns the verified card model
     - Parameter creditCard: Verified card model
     - Parameter failure: Returns the error object that includes error logic
     - Parameter error: CWError object that includes error cause
     
     - throws: `CWError`
     - An error of type `CWError`
     
     */
    @objc public func verifyCreditCard( creditCard : CreditCard,
                                        verifiedAmount : String,
                                        success : @escaping (_ creditCard: CreditCard?) -> (),
                                        failure : @escaping (_ error: CWError?) -> ())
    
    
    /**
     Get your all funding sources
     
     - Parameter success: Returns the added cards
     - Parameter creditCards: All cards that added before
     - Parameter failure: Returns the error object that includes error logic
     - Parameter error: CWError object that includes error cause
     
     - throws: `CWError`
     - An error of type `CWError`
     
     */
    @objc public func getCreditCards(success : @escaping (_ creditCards: [CreditCard]?) -> (),failure : @escaping (_ error: CWError?) -> ())

    /**
     Remove your creditCard for your card management
     
     - Parameter creditCard: Your card that you want to remove
     - Parameter success: Called empty success closure if the card removed succesfully
     - Parameter failure: Returns the error object that includes error logic
     - Parameter error: CWError object that includes error cause
     
     - throws: `CWError`
     - An error of type `CWError`
     
     */
    @objc public func removeCard( creditCard: CreditCard, success : @escaping () -> Void,failure : @escaping (_ error: CWError?) -> ())
```
## Models

### CreditCard
```swift

/// Credit Card for the Funding
@objc public class CreditCard : NSObject {

    @objc public var cardToken = String!
    @objc public var cardNumber : String!
    @objc public var status : CardStatus = .undefined
    @objc public var requiresVerification : Bool = false
    @objc public var canSendNewVerification : Bool = true
    @objc public var verificationAttemptsLeft : NSInteger = 3
}

```

#### Card status

|  Enum   | Description              |
| ------------ | ------------------------|
|  undefined | Default initial state.|
|  pending | Card is added, but waiting for verification.|
|  available | Card is added and verified.|
|  error | There was an error on either adding or verifying the card.|
|  disabled | Card is deleted and won't be used.|

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
    @objc public static let CardExists = 13

```




## UI Customization.
CardWallet SDK supports custom UI for AddCreditCard functionality.

### Add Credit Card Page
You can pass custom xib file with addCreditCard function. Xib file must have some specific tags that you can use while you are adding your card. Tags are mandatory for xib usage.

Scan card feature is optional. If you want to use scan card feature, just supply the tag to any button.

|  View Type   | Descriptionn             |Tag   |
| ------------ | ------------------------ |----- |
|  UIImageView      | Credit Card Type Image      |100104 |
|  SecureTextField | Credit Card Number Field   |100100 |
|  SecureTextField | Expiry Date Field                 |100101 |
|  SecureTextField | CVC Number                       |100102 |
|  SecureTextField | Name Surname                   |100103 |
|  UIButton            | Submit Button                     |100105 |
|  UIButton (Optional) | Scan Button                    |100106 |


### Card Validation On Fly.
CardWallet SDK validates cards on fly at Add Card Page. This feature is optional. In order to use this feature, related error labels must be specified on custom add card xib file. 

#### Views and Tags.
|  View Type | Descriptionn              |Tag    |
| ---------- | ------------------------- |------ |
|  UILabel   | Card Number error label   |100201 |
|  UILabel   | Expiry Date error Label   |100202 |
|  UILabel   | CVC error label           |100203 |
|  UILabel   | Name Surname error label  |100204 |


#### Custom Live Validation Error Messages.
```swift
  @objc static var liveValidationErrorMap = [
        CWSchemeNotSupported : "Card is not supported",
        CWInvalidCardNumber : "Invalid card",
        CWExpireCard : "Card expired",
        CWInvalidExpiration : "Invalid card expiry" ,
        CWInvalidCVV : "Invalid CVV",
        CWInvalidName : "Invalid cardholder name"
      ]
```
This messages are provided as default messages. This messages can be overridden by developers.

In CardWalletSDKBuilder there is a function called setLiveCardValidationCustomErrors. This function takes an Integer - String map. You can override all error messages with this function. 

#### Example Usage
```swift
let builder = CardWalletSDKBuilder()
            .setEnvironment(environment: Environment.STAGING)
            .setCredentialsProvider(provider: self)
            .setLiveCardValidationCustomErrors(errors: [
                CWError.CWInvalidCVV : "CVC Invalid Custom Message",
                CWError.CWExpiredCard : "Expired Card Custom Message"
                ])
        CardWalletSDK.start(builder: builder)
```
It's not necessary to override all messages. Rest of the messages still remain with default messages.

## Version
* 0.1.12
