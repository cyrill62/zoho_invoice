module ZohoInvoice
  class Client
    
    def list_estimates
      response = self.class.get('/estimates', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Estimates.Estimate
    end    
    
    # Search for an invoice by passing either "Estimate Number" or "Customer Name".Only active estimates will be listed. 
    def find_estimates(query)
      @authorization.merge!(:searchtext => query)
      response = self.class.get('/view/search/estimates', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Estimates.Estimate
    end
    
    def list_estimates_for_customer(customer_id)
      response = self.class.post("/estimates/customer/#{customer_id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Estimates.Estimate
    end      
    
    def view_estimate(id)
      response = self.class.get("/estimates/#{id}", :query => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Estimate
    end    
    
    # EXAMPLE: 
    def create_estimate(params = {})
      response = self.class.post('/estimates/create', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response).Response.Estimate
    end
    
    def update_estimate(params = {})
      response = self.class.post('/estimates/update', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response).Response.Estimate
    end
    
    def delete_estimate(id)
      response = self.class.post("/estimates/delete/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
    
    # Sends an estimate to the Customer for whom the estimate was raised. 
    # Parameters to be passed: Custom.Subject, Custom.Body, EstimateID
    def send_estimate(params = {})
      response = self.class.post('/estimates/send', :query => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end    
    
    def mark_estimate_as_send(id)
      response = self.class.post("/estimates/markassent/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end  
       
  end
end