require 'sinatra'
require 'rest_client'
require 'json'

get '/' do
	erb :index
end

get '/organizations' do
	res = RestClient.get 'https://ridb.recreation.gov/api/v1/organizations/', { 'apikey' => "07A6ED14D7D44A058DAC1081BF48D336" }

	resRuby = JSON.parse(res.body)
	@orgs = resRuby['RECDATA']
	erb :organizations
end

get '/recareas' do
	header = {
		'apikey' => "07A6ED14D7D44A058DAC1081BF48D336",
		:params => {
			'state' => "MI"
		}
	}
	res = RestClient.get('https://ridb.recreation.gov/api/v1/recareas/', header)

	resRuby = JSON.parse(res.body)
	@recareas = resRuby['RECDATA']
	erb :recareas
end