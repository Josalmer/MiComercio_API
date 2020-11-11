json.id company.id
json.name company.name
json.logo company.logo
json.type company.type
json.category company.category
json.diaryClientLimit company.diary_client_limit
json.monthlyClientLimit company.monthly_client_limit
json.web company.web
json.mail company.mail
json.phone company.phone
json.description company.description
json.address do
  json.partial! 'api/v1/addresses/address', address: company.address if company.address.direction != company.name
end