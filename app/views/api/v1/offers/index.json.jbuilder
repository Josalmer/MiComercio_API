json.offers @offers do |offer|
  json.id offer.id
  json.companyName offer.company.name
  json.companyId offer.company.id
  json.text offer.text
  json.discount offer.discount
  json.validity offer.validity
end
