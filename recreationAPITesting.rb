require 'sinatra'
require 'rest_client'
require 'json'

configure do
	set :headers, { 'apikey' => "07A6ED14D7D44A058DAC1081BF48D336" }
end

get '/' do
	erb :index
end

get '/organizations' do
	url = 'https://ridb.recreation.gov/api/v1/organizations/'
	res = RestClient.get url, settings.headers

	resRuby = JSON.parse res.body
	@orgs = resRuby['RECDATA'].sort_by { |org| org['OrgName'] }
	erb :organizations
end

get '/organization/:orgId/recareas' do |orgId|
	url = "https://ridb.recreation.gov/api/v1/organizations/#{orgId}/recareas"
	res = RestClient.get url, settings.headers

	resRuby = JSON.parse res.body
	@recareas = resRuby['RECDATA'].sort_by { |recarea| recarea['RecAreaName'] }
	erb :recareas
end

get '/recareas' do
	url = 'https://ridb.recreation.gov/api/v1/recareas/'
	res = RestClient.get url, settings.headers

	resRuby = JSON.parse res.body
	@recareas = resRuby['RECDATA'].sort_by { |recarea| recarea['RecAreaName'] }
	erb :recareas
end

get '/facilities' do
	url = 'https://ridb.recreation.gov/api/v1/facilities/'
	res = RestClient.get url, settings.headers

	resRuby = JSON.parse res.body
	@facilities = resRuby['RECDATA'].sort_by { |facility| facility['FacilityName'] }
	erb :facilities
end

get '/recarea/:recareaId/facilities' do |recareaId|
	url = "https://ridb.recreation.gov/api/v1/recareas/#{recareaId}/facilities/"
	res = RestClient.get url, settings.headers

	resRuby = JSON.parse res.body
	@facilities = resRuby['RECDATA'].sort_by { |facility| facility['FacilityName'] }
	erb :facilities
end

get '/recarea/:recareaId/campgrounds' do |recareaId|
	url = "https://ridb.recreation.gov/api/v1/recareas/#{recareaId}/facilities/"
	header = settings.headers
	header['params'] = { 'query' => "campground" }
	res = RestClient.get url, header

	resRuby = JSON.parse res.body
	@campgrounds = resRuby['RECDATA'].sort_by { |facility| facility['FacilityName'] }
	erb :campgrounds
end

get '/facility/:facilityId/campsites' do |facilityId|
	url = "https://ridb.recreation.gov/api/v1/facilities/#{facilityId}/campsites/"
	res = RestClient.get url, settings.headers

	resRuby = JSON.parse res.body
	@campsites = resRuby['RECDATA'].sort_by { |campsite| campsite['CampsiteName'].to_s }
	erb :campsites
end