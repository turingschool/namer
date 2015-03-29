# make an authenticated client:
# client = Octokit::Client.new(:login => 'username', :password => 'pword')
# ^^ Needs turing org member in order to be able to read teams
# OR
# client = Octokit::Client.new(:access_token => "some-oauth-token")
#
# get team memberships from turing:
# client.organization_teams("turingschool")
# Check if user is member of a team:
# client.team_member?(1171200, "worace") where 1171... is a team id
#
# get all user teams:
# client.user_teams -- this is very convenient but only works if we get the "user"
# oauth scope when users authenticate; this may be too heavy-handed
#
# with 5k reqs/hour rate limit, it is probably feasible to check all whitelisted
# teams
# N reqs / user / auth request
#WHITELISTED_TEAMS = [1109782, 1171200] #1406, 1407
