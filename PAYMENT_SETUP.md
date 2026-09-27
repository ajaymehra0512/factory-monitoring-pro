# UPI Payment Setup

The project is prepared for manual UPI checkout using the configured UPI ID.

Configured UPI:
`ajaymehra720640-1@okicici`

## Important
This is a manual/demo payment flow. A plain UPI ID cannot securely confirm payment to the software by itself.

For automatic subscription activation, later connect a merchant payment gateway and configure:
- merchant account
- API credentials in `.env`
- checkout creation
- payment verification
- webhook
- subscription activation/renewal

Never put API secrets, UPI PIN, OTP, bank password, or card details in frontend code.

## Test/manual flow
Customer selects a plan -> payment instructions show -> customer pays in their UPI app -> admin verifies payment -> subscription is activated.

Do not treat a screenshot or client-side success message as proof of payment.
