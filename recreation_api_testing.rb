require 'sinatra'
require 'sass'
require 'rest_client'
require 'json'
require './campsite'

configure do
	set :headers, { 'apikey' => '07A6ED14D7D44A058DAC1081BF48D336' }
end

get '/' do
	erb :index
end

get '/organizations' do
	url = 'https://ridb.recreation.gov/api/v1/organizations/'
	res = RestClient.get url, settings.headers

	res_ruby = JSON.parse res.body
	@orgs = res_ruby['RECDATA'].sort_by { |org| org['OrgName'] }
	erb :organizations
end

get '/organization/:orgId/recareas' do |orgId|
	url = "https://ridb.recreation.gov/api/v1/organizations/#{orgId}/recareas"
	res = RestClient.get url, settings.headers

	res_ruby = JSON.parse res.body
	@recareas = res_ruby['RECDATA'].sort_by { |recarea| recarea['RecAreaName'] }
	erb :recareas
end

get '/recareas' do
	url = 'https://ridb.recreation.gov/api/v1/recareas/'
	res = RestClient.get url, settings.headers

	res_ruby = JSON.parse res.body
	@recareas = res_ruby['RECDATA'].sort_by { |recarea| recarea['RecAreaName'] }
	erb :recareas
end

get '/facilities' do
	url = 'https://ridb.recreation.gov/api/v1/facilities/'
	res = RestClient.get url, settings.headers

	res_ruby = JSON.parse res.body
	@facilities = res_ruby['RECDATA'].sort_by { |facility| facility['FacilityName'] }
	erb :facilities
end

get '/recarea/:recareaId/facilities' do |recareaId|
	url = "https://ridb.recreation.gov/api/v1/recareas/#{recareaId}/facilities/"
	res = RestClient.get url, settings.headers

	res_ruby = JSON.parse res.body
	@facilities = res_ruby['RECDATA'].sort_by { |facility| facility['FacilityName'] }
	erb :facilities
end

get '/recarea/:recareaId/campgrounds' do |recareaId|
	url = "https://ridb.recreation.gov/api/v1/recareas/#{recareaId}/facilities/"
	header = settings.headers
	header['params'] = { 'query' => "campground" }
	res = RestClient.get url, header

	res_ruby = JSON.parse res.body
	@campgrounds = res_ruby['RECDATA'].sort_by { |facility| facility['FacilityName'] }
	erb :campgrounds
end

get '/facility/:facilityId/campsites' do |facilityId|
	url = "https://ridb.recreation.gov/api/v1/facilities/#{facilityId}/campsites/"
	res = RestClient.get url, settings.headers

	res_ruby = JSON.parse res.body
  @campsites = res_ruby['RECDATA'].map { |campsite| Campsite.new campsite['CampsiteName'] }.sort!
	erb :campsites
end

get '/style' do
	sass :styles
end
