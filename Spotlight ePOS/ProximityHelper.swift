//
//  ProximityHelper.swift
//  Spotlight ePOS
//
//  Created by Lu on 17/1/23.
//

import Foundation
import ProximityReader

class ProximityHelper {
    var reader: PaymentCardReader?
    var session: PaymentCardReaderSession?
    init() {
        guard PaymentCardReader.isSupported else {
            // This device doesn't support Tap to Pay on iPhone.
            return
        }
        reader = PaymentCardReader()
    }
    
    public func presentTermsAndConditions(pspToken: String) async throws {
        let token = PaymentCardReader.Token(rawValue: pspToken)
        // Confirm that the user is an admin. Otherwise, display a message that
        // states only admins may accept the Terms and Conditions.
        do {
            try await reader?.linkAccount(using: token)
        } catch {
            // Handle any errors that occur during linking.
        }
    }
    
    public func configureDevice(pspToken: String) async throws {
        let token = PaymentCardReader.Token(rawValue: pspToken)
        guard let reader = self.reader else {
            return
        }
        let events = reader.events
        do {
            Task {
                for await event in events {
                    if case .updateProgress = event {
                        // Make sure you update the user interface (if you have one)
                        // using the progress value.
                    }
                }
            }
            session = try await reader.prepare(using: token)
        } catch {
            // Handle any errors that occur during preparation
            // (see PaymentCardReaderError).
        }
    }
    
    public func readCard(for amount: Decimal) async throws {
        let request = PaymentCardTransactionRequest(amount: amount,
                                                    currencyCode: "USD",
                                                    for: .purchase)
        guard let reader = self.reader else {
            return
        }
        let events = reader.events
        do {
            Task {
                for await event in events {
                    // Handle events that happen while the sheet is up.
                }
            }
            let result = try await session?.readPaymentCard(request)
            // Send result.paymentCardData to your payment service provider.
        } catch {
            // Handle any errors that occur during read
            // (see PaymentCardReaderSession.ReadError).
        }
    }
}
