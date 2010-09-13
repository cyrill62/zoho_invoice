module ZohoInvoice
  class Client
    
    # INVOICE PAYMENTS
    
    def list_payments_for_invoice(invoice_id)
      response = self.class.get("/payments/#{invoice_id}", :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
    
    # EXAMPLE:
    def create_payment(params = {})
      response = self.class.post('/payments/create', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def create_payment(params = {})
      response = self.class.post('/payments/update', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def delete_payment(id)
      response = self.class.post("/payments/delete/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
    
    # CREDIT PAYMENTS
    
    def list_credits_for_customer(customer_id)
      response = self.class.get("/customers/credits/#{customer_id}", :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
    
    # EXAMPLE:
    def create_credit(params = {})
      response = self.class.post('/customers/credits/create', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def create_payment(params = {})
      response = self.class.post('/customers/credits/update', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def delete_payment(id)
      response = self.class.post("/customers/credits/delete/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end    
       
  end
end