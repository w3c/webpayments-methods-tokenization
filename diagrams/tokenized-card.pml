@startuml

participant "Merchant (or PSP)" as Payee
participant "Browser" as UA
actor "Payer" as Payer
participant "Payment Handler" as PH
participant "TSP" as TSP

title First request for one-time use, recurring, card-on-file token

== Checkout ==

Payee->UA: Serve check-out page
UA->Payer: Present check-out page with PR API('tokenized-card' or 'token-reference')
UA<-Payer: Push Buy button
UA->Payer: Offer Payment Handlers matching request filters (supportedNetworks, supportedTypes, usageType)
UA<-Payer: Select Payment Handler
UA->PH: Launch Payment Handler
Payer<-PH: Display cards
Payer->PH: Choose card

== Tokenization ==

note over PH, TSP: Authentication, token caching, payment handler verification, and other payment handler details out of scope.

PH->TSP: Request data 
PH<-TSP: Return data (token, cryptogram, etc.)
UA<-PH: Return 'tokenized-card' or 'token-reference' method data
Payee<-UA: Return payment response

@enduml
