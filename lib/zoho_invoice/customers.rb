module ZohoInvoice
  class Client
    
    def list_customers
      response = self.class.get('/customers', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end    

    def list_inactive_customers
      response = self.class.get('/customers/inactive', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end    
    
    # Search for a customer by passing either "Customer Name" or "Customer Notes". Only active customers will be listed.
    def find_customers(query)
      @authorization.merge!(:searchtext => query)
      response = self.class.get('/view/search/customers', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def view_customer(id)
      response = self.class.get("/customers/#{id}", :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end    
    
    # EXAMPLE: create_customer(:customer => {:name => 'Someone'})
    def create_customer(params = {})
      response = self.class.post('/customers/create', request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def update_customer(params = {})
      response = self.class.post('/customers/update', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def delete_customer(id)
      response = self.class.post("/customers/delete/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end    
    
    def mark_customer_as_inactive(id)
      response = self.class.post("/customers/markasinactive/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
    
    # Sends a statement to the Customer specified. 
    # Params to be passed: Custom.Subject, Custom.Body, CustomerID, StartDate, EndDate 
    def send_customer_statement(params ={})
      response = self.class.post('/customers/sendstatement', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end
    
    # View a customer statement.
    # Params to be passed: CustomerID, StartDate, EndDate    
    def view_customer_statement(params ={})
      response = self.class.post('/customers/getstatement ', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end    
  
  end
end