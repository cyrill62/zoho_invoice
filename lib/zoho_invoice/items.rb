module ZohoInvoice
  class Client
    
    def list_items
      response = self.class.get('/items', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Items.Item
    end
    
    def list_inactive_items
      response = self.class.get('/items/inactive', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Items.Item
    end
    
    def find_items(query)
      @authorization.merge!(:searchtext => query)
      response = self.class.get('/view/search/items', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Items.Item
    end
    
    def view_item(id)
      response = self.class.get("/items/#{id}", :query => @authorization, :format => :xml)
      Hashie::Mash.new(response).Response.Item
    end    
    
    # EXAMPLE: create_item(Item => {'Name' => 'Sample', 'Description' => 'sample description', 'Rate' => 34})
    def create_item(params = {})
      response = self.class.post('/items/create', :body => request_body(params), :format => :xml)
      Hashie::Mash.new(response).Response.Item
    end
    
    # EXAMPLE: update_item(Item => {'ItemID' => 4000000002026, 'Name' => 'Sample', 'Description' => 'sample description', 'Rate' => 34})
    def update_item(params = {})
      response = self.class.post('/items/update', :body => request_body(params), :format => :xml)
      Hashie::Mash.new(response).Response.Item
    end
    
    def delete_item(id)
      response = self.class.post("/items/delete/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end    
    
    def mark_item_as_inactive(id)
      response = self.class.post("/items/markasinactive/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
       
  end
end