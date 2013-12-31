#
# Simulates a sale to determine if sale will be viable
#
# @author Gordon B. Isnor
#
module Cantook
	class SimulateASale < Cantook::Base

		# https://[platform]/api/organisations/[organisation_id]/publications/[isbn]/sales/new
		
		# GET REQUEST

		# PARAMETERS
		# Name							Mandatory		Description
		# cost							Yes					The price of the sale in cents (e.g., $19.99 => 1999).
		# protection				Yes					The type of protection on the sold publication (none/watermark/acs4/acs4_time_limited).
		# country						No					The country which will be considered to validate the price of the publication. Value by default: the country of your organization. ISO 3166-1 alpha-3 (can, fra, ita) format.
		
		# RESPONSE CODES
		# Code 	Content								Description
		# 200		valid									The simulation was executed successfully.
		# 400		cannot_sell						You cannot sell this publication.
		# 400		missing_isbn					You did not enter the ISBN.
		# 400		missing_format				You did not enter the format.
		# 400		invalid_format				The selected format is not available for this publication.
		# 400		missing_cost					You did not enter the price.
		# 400		invalid_cost					The price does not correspond to the price in the Platform.
		# 400		missing_protection		You did not enter the protection type.
		# 400		invalid_protection		This protection is not available for this format of the publication.
		# 401		access_denied					You do not have access to the resource.
		# 404		not_found							Your organization could not be found.
		# 503		service_unavailable		A problem has occured while connecting to the server.
		
		attr_accessor :cost, :protection, :country

		# Example:	
		# base_hash = { username: Settings.cantook.username, password: Settings.cantook.password, platform: Settings.cantook.platform, organisation_id: Settings.cantook.organisation_id, sale_state: Settings.cantook.sale_state, format: 'epub', isbn: '123456789asdf' }
		# simulate_hash = { cost: '999', protection: 'acs4', country: nil }
		# cantook = Cantook::SimulateASale.new(base_hash)		
		# result = cantook.simulate_a_sale(simulate_hash)
		# @param [Hash] params
		# @option params [Integer] :cost - price in cents
		# @option params [String] :protection - the file’s DRM protection eg 'acs4'
		# @option params [String] :country - eg 'can'
		# @return [True] if response code is 200
		# @return [False] if response code is not 200
		def simulate_a_sale(params)
			self.cost = params[:cost]
			self.protection = params[:protection]
			self.country = params[:country]
			do_request
			response.code == 200
		end

		# sets and returns the response
		def do_request
			self.response = get_request(options)
		end
		private :do_request

		# @return [String] The full url required for this request
		def request_url
			base_url + "/publications/#{isbn}/sales/new"
		end
		private :request_url

		# @return [Hash] required parameters not included in the Cantook::Base base_options hash
		def options
			{ cost: cost, protection: protection, country: country }
		end
		private :options

	end
end