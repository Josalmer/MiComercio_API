json.id user.id
json.email user.email
json.name user.name
json.surname user.surname
json.phone user.phone
json.userRole user.organization_manager ? 'manager' : 'user'
json.paymentPreference do
  json.partial! 'api/v1/payment_preferences/payment_preference', payment_preference: user.payment_preference if user.organization_manager
end