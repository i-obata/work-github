class Public::CustomersController < ApplicationController
    
    def show
        @customer = current_customer
    end
    
    def edit
        @customer = current_customer
    end
    
    def update
        customer = current_customer
        if customer.update(customer_params)
        flash[:notice] = "successfully edited the user!"
            redirect_to customers_path
        else
            render :edit
        end
    end
    
    def confirm_withdraw
    end
    
    def withdraw
    end
end
