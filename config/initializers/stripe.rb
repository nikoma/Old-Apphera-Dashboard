Rails.configuration.stripe = {
    :publishable_key => 'pk_live_pZP5stSjFjv4glVLDxt0KVcc',
    :secret_key      => 'sk_live_GZtbILLUdAkypyB5McTrs7tE'
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
