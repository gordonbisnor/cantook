#
# Provides a download link that customer should be redirected to
#
# @author Gordon B. Isnor
#
module Cantook
	class DownloadAPublication < Cantook::Base

		# https://[platform]/api/organisations/[organisation_id]/customers/[customer_id] /transactions/[transaction_id]/publications/[isbn]/download_links/[format]

		# GET REQUEST

		# PARAMETERS
		# customer_id			Yes					The client's unique ID number. Alphanumerical characters ("-" and "_" accepted).
		# transaction_id	Yes					The transaction / purchase basket's unique ID number.
		# uname						Yes					First and last name of the user. The value of this parameter will appear in the text of the digital watermark that will be placed on the file.

		# RESPONSE CODES
		# Code	Content									Description
		# 200		url											Chronodegradable download URL (expires after 1 minute). Redirect user toward this URL.
		# 400		missing_transaction_id	You did not enter a transaction ID.
		# 401		access_denied						You do not have access to the resource.
		# 404		not_found								Your organisation could not be found.

		attr_accessor :customer_id, :transaction_id, :uname
		
		# Example:
		# base_hash = { username: Settings.cantook.username, password: Settings.cantook.password, platform: Settings.cantook.platform, organisation_id: Settings.cantook.organisation_id, sale_state: Settings.cantook.sale_state, format: 'epub', isbn: '123456789asdf' }
		# download_hash = { customer_id: '123', transaction_id: 'abc', uname: 'Foo Bar' }
		# cantook = Cantook::DownloadAPublication.new(base_hash)
		#	download_link = cantook.download_a_publication(download_hash)
		# redirect_to download_link
		#
		# @param [Hash] params
		# @option params [String] :customer_id - your customer’s unique ID
		# @option params [String] :transaction_id - the orders unique ID  
		# @option params [String] :uname - Your customer’s first and last name, for the watermark
		# @return [String] If successful, returns the download link 
		def download_a_publication(params)
			self.customer_id = params[:customer_id]
			self.transaction_id = params[:transaction_id]
			self.uname = params[:uname]
			do_request
			response.parsed_response
		end

		# sets and returns the response
		def do_request
			self.response = get_request(options)
		end
		private :do_request

		# @return [String] The full url required for this request
		def request_url
			base_url + "/customers/#{customer_id}/transactions/#{transaction_id}/publications/#{isbn}/download_links/#{format}"
		end

		# @return [Hash] required parameters not included in the Cantook::Base base_options hash
		def options
			{ customer_id: customer_id, transaction_id: transaction_id, uname: uname }
		end
		private :options

	end

end