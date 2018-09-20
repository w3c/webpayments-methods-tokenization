@startuml

participant "Merchant (or PSP)" as Payee
participant "Browser" as UA
actor "Payer" as Payer
participant "Payment Handler" as PH
participant "TSP" as TSP

title Subsequent cryptogram request for previous card-on-file token
note over Payer: For merchants who do not have backend integrations to use Payment Request API for subsequent cryptograms.


== Checkout ==

Payee->UA: Serve check-out page
UA->Payer: Present check-out page with PR API('token-cryptogram')
UA<-Payer: Push Buy button
note over PH: Open question: narrow matching if payment handler is token requestor; browser matching if payee is token requestor.
UA->Payer: Offer Payment Handler matching request filters (tokenReferenceID or PAN, tokenRequestorID)
alt Skip-the-sheet flow
UA->PH: Launch Payment Handler
else Show the sheet flow
UA<-Payer: Select Payment Handler
UA->PH: Launch Payment Handler
end

note over UA,PH: The payment handler may not require user interaction before fetching the cryptogram.

== Tokenization ==

note over PH, TSP: Authentication, token caching, payment handler verification, and other payment handler details out of scope.

PH->TSP: Request data
PH<-TSP: Return data (cryptogram)
UA<-PH: Return 'token-cryptogram' method data
Payee<-UA: Return payment response

@enduml
