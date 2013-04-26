User.seed do |s|
  s.id = 10
  s.email = "abc@gmail.com"
  s.name = "abc"
  s.encrypted_password = "$2a$10$Zgwf70y0gHpLTNVFTtB/7.0GKBsMz0a3qqZqtgOwi2b5grLcAfFVy"
  s.account_id = 10
  s.reseller_id = 1
  s.is_reseller = 1
  s.referred_by = 1
end