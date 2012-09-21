# "{'foo': 'bar'}".should match_json {:foo => :bar}
RSpec::Matchers.define :match_json do |expected|
  match do |actual|
    ActiveResource::Formats::JsonFormat.decode(actual) == ActiveResource::Formats::JsonFormat.decode(expected.to_json)
  end
end
