#
# Notifies Cantook of sale
#
# @author Gordon B. Isnor
#
module Cantook
	class SaleOfAPublication < Cantook::Base

		# https://[platform]/api/organisations/[organisation_id]/publications/[isbn]/sales
		
		# POST REQUEST
		
		# PARAMETERS
		# Name								Mandatory	Description
		# cost								Yes				The price of the sale in cents (e.g., $19.99 => 1999).
		# protection					Yes				The type of protection on the sold publication (none/watermark/acs4/acs4_time_limited).
		# customer_id					Yes				Your client's unique ID number. Alphanumerical characters only ("-" and "_" also accepted).
		# transaction_id			Yes				The transaction / purchase basket's unique ID number. Multiple sales can be added to a basket, as long as they have the same unique ID number and are related to a single user. Alphanumerical characters only ("-" and "_" also accepted).
		# credit_card_prefix	No				4 first numbers of the credit card number used for payment. It allows the publisher to check if the territory constraints (determined by these 4 first numbers) are respected.
		# sale_state					No				The sale state. By default, a sale is always in "active" state, but it is possible to specify that the sale must be in "test" state using this parameter. Possible values: active / test
		# country							Yes				The country which will be considered to validate the price of the publication. 
		# aggregator					No				When a parent store makes a sale for one of it's child store, this field represents the ID of the parent store.
		# uname								No				First and last name of the user. The value of this parameter will appear in the text of the digital watermark that will be placed on the file. When this parameter is provided on Sale API call, the watermarking delay will be shortened on the download request (the download will begin as soon as the user clicks on the download button instead of waiting for the platform to generate the watermarked copy).

		# RESPONSE CODES
		# Code	Content									Description
		# 201		created									The sale has been added successfully.
		# 400		cannot_sell							You cannot sell this publication.
		# 400		missing_isbn						You did not enter the ISBN.
		# 400		missing_format					You did not enter the format.
		# 400		invalid_format					The selected format is not available for this publication.
		# 400		missing_cost						You did not enter the price.
		# 400		invalid_cost						The price does not correspond to the price in the Platform.
		# 400		missing_customer_id			You did not enter your client's unique ID number.
		# 400		missing_transaction_id	You did not enter the transaction's unique ID number.
		# 400		missing_protection			You did not enter the protection type.
		# 400		invalid_protection			This protection is not available for this format of the publication.
		# 400		invalid_sale_state			The sale state is invalid.
		# 401		duplicate								The sale already exists.
		# 401		access_denied						You do not have access to the resource.
		# 404		not_found								Your organization could not be found.
		# 503		service_unavailable			A problem has occured while connecting to the server.

		# TEST BOOKS
		# Title: test-1. PDF format: 9990000000001 ePub format: 9991000000001 protection: watermark (“protection=watermark”) cost: $0, 0 euro (“cost=0”)
		# Title: test-2. PDF format: 9990000000002 ePub format: 9991000000002 protection: ACS4 (“protection=acs4”) cost: $1.00, 1.00 euro (“cost=100”)
		# Title: test-3. PDF format: 9990000000003 ePub format: 9991000000003 protection : ACS4 (“protection=acs4”) cost: $0, 0 euro (“cost=0”)

		attr_accessor :cost, 
			:protection, 
			:customer_id, 
			:transaction_id, 
			:credit_card_prefix, 
			:sale_state, 
			:country, 
			:aggregator, 
			:uname

		# Example:
		# base_hash = { username: Settings.cantook.username, password: Settings.cantook.password, platform: Settings.cantook.platform, organisation_id: Settings.cantook.organisation_id, sale_state: Settings.cantook.sale_state, format: 'epub', isbn: '123456789asdf' }
		# sale_hash = { cost: '999', customer_id: '123', transaction_id: 'abc', protection: 'acs4' }
		# cantook = Cantook::SaleOfAPublication.new(base_hash)
		# if cantook.sale_of_a_publication(sale_hash)
		#	  puts "mais oui"
		# else
		#   puts "mais non"
		# end
		#
		# @param [Hash] params
		# @option params [Integer] :cost - price in cents
		# @option params [String] :protection - the file’s DRM protection eg 'acs4'
		# @option params [String] :customer_id - the customer’s unique ID
		# @option params [String] :transaction_id - the order’s unique ID
		# @return [True] if response code is 201
		# @return [False] if resopnse code is anything other than 201	
		def sale_of_a_publication(params)
			self.cost = params[:cost]
			self.protection = params[:protection]
			self.customer_id = params[:customer_id]
			self.transaction_id = params[:transaction_id]
			do_request
			response.code == 201
		end

		# sets and returns the response
		def do_request
			self.response = post_request(options)
		end
		private :do_request

		# @return [String] The full url required for this request
		def request_url
			base_url + "/publications/#{isbn}/sales"
		end

		# @return [Hash] required parameters not included in the Cantook::Base base_options hash
		def options
			{
				cost: cost,
				protection: protection,
				customer_id: customer_id,
				transaction_id: transaction_id,
				credit_card_prefix: credit_card_prefix,
				sale_state: sale_state,
				country: country,
				aggregator: aggregator,
				uname: uname
			}
		end
		private :options

	end
end