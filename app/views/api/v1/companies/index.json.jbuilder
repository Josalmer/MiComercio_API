json.companies @companies do |company|
  json.partial! 'api/v1/companies/company', company: company
end
