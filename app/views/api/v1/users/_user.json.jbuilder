json.id user.id
json.email user.email
json.name user.name
json.surname user.surname
json.phone user.phone
json.userRole user.organization_manager ? 'manager' : 'user'
json.paymentPreference do
  if user.organization_manager
    json.partial! 'api/v1/payment_preferences/payment_preference', payment_preference: user.payment_preference
  end
end
