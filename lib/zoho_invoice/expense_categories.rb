module ZohoInvoice
  class Client
    
    def list_expense_categories
      response = self.class.get('/expensecategories', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def list_inactive_expense_categories
      response = self.class.get('/expensecategories/inactive', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def list_active_expense_categories
      response = self.class.get('/expensecategories/active', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end    
    
    def find_expense_categories(query)
      @authorization.merge!(:searchtext => query)
      response = self.class.get('/view/search/expensecategories', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def view_expense_category(id)
      response = self.class.get("/expensecategories/#{id}", :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end    
    
    # EXAMPLE:
    def create_expense_category(params = {})
      response = self.class.post('/expensecategories/create', :body => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end
    
    # EXAMPLE:
    def update_expense_category(params = {})
      response = self.class.post('/expensecategories/update', :body => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def delete_expense_category(id)
      response = self.class.post("/expensecategories/delete/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end    
    
    def mark_expense_category_as_inactive(id)
      response = self.class.post("/expensecategories/markasinactive/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
       
  end
end