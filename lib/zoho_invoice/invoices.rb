module ZohoInvoice
  class Client
    
    def list_invoices
      response = self.class.get('/invoices', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Invoices.Invoice
    end    
    
    # Search for an invoice by passing either "Invoice Number" or "Customer Name". Only active invoices will be listed. 
    def find_invoices(query)
      @authorization.merge!(:searchtext => query)
      response = self.class.get('/view/search/invoices', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Invoices.Invoice
    end
    
    def list_invoices_for_customer(customer_id)
      response = self.class.post("/invoices/customer/#{customer_id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Invoices.Invoice
    end    
    
    def view_invoice(id)
      response = self.class.get("/invoices/#{id}", :query => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Invoice
    end    
    
    # EXAMPLE: create_customer(:customer => {:name => 'Someone'})
    def create_invoice(params = {})
      response = self.class.post('/invoices/create', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response).Response.Invoice
    end
    
    def update_invoice(params = {})
      response = self.class.post('/invoices/update', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response).Response.Invoice
    end
    
    def delete_invoice(id)
      response = self.class.post("/invoices/delete/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
    
    # Sends an Invoice to the Customer for whom the invoice was raised. 
    # Parameters to be passed: Custom.Subject, Custom.Body, InvoiceID 
    def send_invoice(params = {})
      response = self.class.post('/invoices/send', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end    
    
    # Sends an Invoice to the Customer for whom the invoice was raised. 
    # Parameters to be passed: Custom.Subject, Custom.Body, InvoiceID
    def send_invoice_reminder(params = {})
      response = self.class.post('/invoices/sendreminder', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def convert_invoice_to_open(id)
      response = self.class.post("/invoices/converttoopen/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end    
  
  end
end