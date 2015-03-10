require 'sinatra'
require 'rest_client'
require 'json'

get '/' do
	erb :index
end

get '/organizations' do
	url = 'https://ridb.recreation.gov/api/v1/organizations/'
	headers = {
		'apikey' => "07A6ED14D7D44A058DAC1081BF48D336"
	}
	res = RestClient.get url, headers

	resRuby = JSON.parse(res.body)
	@orgs = resRuby['RECDATA']
	erb :organizations
end

get '/organization/:orgId/recareas' do |orgId|
	url = "https://ridb.recreation.gov/api/v1/organizations/#{orgId}/recareas"
	headers = {
		'apikey' => "07A6ED14D7D44A058DAC1081BF48D336"
	}
	res = RestClient.get url, headers

	resRuby = JSON.parse(res.body)
	@recareas = resRuby['RECDATA']
	erb :recareas
end

get '/recareas' do
	url = 'https://ridb.recreation.gov/api/v1/recareas/'
	header = {
		'apikey' => "07A6ED14D7D44A058DAC1081BF48D336",
		:params => {
			'state' => "MI"
		}
	}
	res = RestClient.get url, header

	resRuby = JSON.parse(res.body)
	@recareas = resRuby['RECDATA']
	erb :recareas
end

get '/recarea/:recareaId/facilities' do |recareaId|
	url = "https://ridb.recreation.gov/api/v1/recareas/#{recareaId}/facilities/"
	headers = {
		'apikey' => "07A6ED14D7D44A058DAC1081BF48D336"
	}
	res = RestClient.get url, headers

	resRuby = JSON.parse(res.body)
	@facilities = resRuby['RECDATA']
	erb :facilities
end