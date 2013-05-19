Rails.configuration.stripe = {
    :publishable_key => 'pk_live_xxxx',
    :secret_key      => 'sk_live_xxx'
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]
