require 'square'
# Set your Square credentials
export SQUARE_ACCESS_TOKEN=EAAAEMlb7GoA0uzzOCMGu-A5X58RtjLAzB2NA0AFMntsjgsmaQAobty-8Wcu1KJQ


client = Square::Client.new(
  access_token: ENV.fetch('SQUARE_ACCESS_TOKEN'),
  environment: 'sandbox',
  timeout: 1
)

result = client.locations.list_locations

if result.success?
  result.data.locations.each do |location|
    printf("%s: %s, %s, %s\n",
           location[:id],
           location[:name],
           location[:address][:address_line_1],
           location[:address][:locality])
  end

elsif result.error?
  result.errors.each do |error|
    warn error[:category]
    warn error[:code]
    warn error[:detail]
  end
end
