module ZohoInvoice
  class Client
    
    def list_expenses
      response = self.class.get('/expenses', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
    
    # Search for an expense by passing either "Category Name", "Expense Description" or "Customer Name".
    def find_expenses(query)
      @authorization.merge!(:searchtext => query)
      response = self.class.get('/view/search/expenses', :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def view_expense(id)
      response = self.class.get("/expenses/#{id}", :query => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end    
    
    # EXAMPLE: 
    def create_expense(params = {})
      response = self.class.post('/expenses/create', :body => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end
    
    # EXAMPLE: 
    def update_expense(params = {})
      response = self.class.post('/expenses/update', :body => request_body(params), :format => :xml)
      Hashie::Mash.new(response)
    end
    
    def delete_expense(id)
      response = self.class.post("/expensess/delete/#{id}", :body => @authorization, :format => :xml)
      Hashie::Mash.new(response)
    end
       
  end
end