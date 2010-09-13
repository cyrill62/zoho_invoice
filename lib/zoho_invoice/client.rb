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
      zoho_config = YAML::load_file(RAILS_ROOT+'/config/zoho_invoice.yml')
      
      api_key = zoho_config['api_key']
      secret_key = zoho_config['secret_key'] # dont't know what it's used for o_0
      username = zoho_config['username']
      password = zoho_config['password']
      last_ticket_date = zoho_config['last_ticket_date']
      
      # a zoho ticket stays valid for 7 days
      # create a new one if ticket is expired
      if last_ticket_date + 7.days <= Date.today
        response = self.class.get("https://accounts.zoho.com/login",
                     :format => :html,
                     :query => {
                     :service_name => 'ZohoInvoice',
                     :FROM_AGENT => true,
                     :LOGIN_ID => username,
                     :PASSWORD => password
                     })
        ticket = response.scan(/TICKET=(.{32})/).to_s
        zoho_config['ticket'] = ticket
        zoho_config['last_ticket_date'] = Date.today
        File.open("#{RAILS_ROOT}/config/zoho_invoice.yml", 'w') { |f| YAML.dump(zoho_config, f) }
      else
        ticket = zoho_config['ticket']
      end
      
      @authorization = {:ticket => ticket, :apikey => api_key}
    end
    
    def request_body(params)
      body = {:XMLString => params.to_xml}
      body.merge!(@authorization)
    end
    
  end
end