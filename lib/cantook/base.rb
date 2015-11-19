#
# Base class sets up common functionality for other classes to inherit behavior from
#
# @author Gordon B. Isnor
#
module Cantook

	class Base
		
		# Name							Mandatory		Description
		# platform					Yes					The platform that you're using to connect to your account. For example : www.entrepotnumerique.com, www.edenlivres.fr, edigita.cantook.net or transcontinental.cantook.net.
		# organisation_id		Yes					Your merchant number. This number is provided upon registration.
		# isbn							Yes					The publication's ISBN.
		# format						Yes					The publication's format (pdf/epub/mobi).

		attr_accessor :base_url,
			:auth,
			:username,
			:password,
			:platform, 
			:organisation_id, 
			:isbn,
			:format,
			:response,
			:query,
			:sale_state,
			:currency,
			:country

		# @param [Hash] params
		# @option params [String] :username - your Cantook API username
		# @option params [String] :username - your Cantook API password
		# @option params [String] :platform - your Cantook platform eg 'www.cantook.net'
		# @option params [String] :organisation_id - your Cantook organisation ID number
		# @option params [String] :isbn - ISBN of the publication you are selling
		# @option params [String] :format - format of the publication being sold, eg 'epub' or 'mobi'
		# @option params [String] :sale_state - use 'test' for test/development, nil for production (real sales)
		# @option params [String] :currency - 3-letter ISO-4217 code
		def initialize(params = {})
			@username = params[:username]
			@password = params[:password]
			@platform = params[:platform]
			@organisation_id = params[:organisation_id]
			@isbn = params[:isbn]
			@format = params[:format]
			@sale_state = params[:sale_state]
			@currency = params[:currency]
			@country = params[:country]
			@base_url = "https://#{platform}/api/organisations/#{organisation_id}"
			@auth = { username: username, password: password }
		end

		# @return [Hash] A basic hash of options common to all Cantook requests
		def base_options
			{ format: format, isbn: isbn, sale_state: sale_state, currency: currency, country: country }
		end
		private :base_options

		# @param [Hash] options
		def get_request options
			self.query = options.merge(base_options)
			HTTParty.get(request_url, query: query, basic_auth: auth)
		end
		private :get_request

		# @param [Hash] options
		def post_request options
			self.query = options.merge(base_options)
			HTTParty.post(request_url, query: query, basic_auth: auth)
		end
		private :post_request

		# @return [Fixnum] the response code of the Cantook request
		def response_code
			response.code
		end

		# @return [Hash] The response hash, with symbolized keys
		def response_hash
			response.parsed_response.deep_symbolize_keys!
		end

	end

end