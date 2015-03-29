DNSIMPLE = Dnsimple::Client.new(username: ENV["DNSIMPLE_EMAIL"], api_token: ENV["DNSIMPLE_TOKEN"])

# fetch records for a domain:
#
#
# delete a record for a domain:
# DNSIMPLE.domains.delete_record("turingapps.io", 3840222) where 384... is the record's id
#
# create a record:
# DNSIMPLE.domains.create_record("turingapps.io",
# record_type: "ALIAS",
# name: "",
# content: "shielded-savannah-4396.herokuapp.com")
