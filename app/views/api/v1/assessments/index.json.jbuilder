json.assessments @assessments do |assessment|
  json.partial! 'api/v1/assessments/assessment', assessment: assessment
end
