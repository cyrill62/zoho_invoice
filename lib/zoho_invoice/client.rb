require 'zoho_invoice/customers'
require 'zoho_invoice/items'
require 'zoho_invoice/invoices'
require 'zoho_invoice/expenses'
require 'zoho_invoice/expense_categories'
require 'zoho_invoice/estimates'
require 'zoho_invoice/payments'

module ZohoInvoice
  class Client
    include HTTParty
    base_uri 'https://invoice.zoho.com/api'

    def initialize(options = {})
      config_path = options[:config_path] || (defined?(Rails) ? File.join(Rails.root, 'config') : raise)
      config_file = File.join(config_path, 'zoho_invoice.yml')
      zoho_config = options[:config] || YAML::load_file(config_file)

      api_key = zoho_config['api_key']
      secret_key = zoho_config['secret_key'] # dont't know what it's used for o_0
      username = zoho_config['username']
      password = zoho_config['password']
      last_ticket_date = zoho_config['last_ticket_date'] || Date.parse('01/01/1970')

      # a zoho ticket stays valid for 7 days
      # create a new one if ticket is expired
      if last_ticket_date + 7 <= Date.today
        response = self.class.get("https://accounts.zoho.com/apiauthtoken/nb/create", :query => {
                     :SCOPE => 'invoiceapi',
                     :EMAIL_ID => username,
                     :PASSWORD => password
                     })
        ticket = response.scan(/AUTHTOKEN=(.*)$/).first.first
        unless ticket.empty?
          zoho_config['ticket'] = ticket
          zoho_config['last_ticket_date'] = Date.today
          File.open(config_file, 'w') { |f| YAML.dump(zoho_config, f) } unless options[:config]
        end
      else
        ticket = zoho_config['ticket']
      end

      @authorization = {:authtoken => ticket, :apikey => api_key, :scope => 'invoiceapi'}
    end

    def request_body(params)
      body = {:XMLString => params.to_xml}
      body.merge!(@authorization)
    end

  end
end
