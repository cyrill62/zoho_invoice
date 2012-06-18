module ZohoInvoice
  class Client

    # INVOICE PAYMENTS

    def list_payments_for_invoice(invoice_id)
      response = self.class.get("/payments/#{invoice_id}", :query => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Payments.Payment
    end

    # EXAMPLE:
    def create_payment(params = {})
      response = self.class.get('/payments/create', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response).Response.Payment
    end

    def create_payment(params = {})
      response = self.class.post('/payments/update', :body => request_body(params), :format => :xml)
      Hashie::Mash.new(response).Response.Payment
    end

    def delete_payment(id)
      response = self.class.post("/payments/delete/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end

    # CREDIT PAYMENTS

    def list_credits_for_customer(customer_id)
      response = self.class.get("/customers/credits/#{customer_id}", :query => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.CustomerCredit.Credit
    end

    # EXAMPLE:
    def create_credit(params = {})
      response = self.class.post('/customers/credits/create', :body => request_body(params), :format => :xml)
      Hashie::Mash.new(response).Response.CustomerCredit
    end

    def update_credit(params = {})
      response = self.class.post('/customers/credits/update', :body => request_body(params), :format => :xml)
      Hashie::Mash.new(response).Response.CustomerCredit
    end

    def delete_payment(id)
      response = self.class.post("/customers/credits/delete/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end

  end
end