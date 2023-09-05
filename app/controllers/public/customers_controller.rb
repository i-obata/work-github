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
        flash[:notice] = "successfully edited the customer!"
            redirect_to customers_path
        else
            render :edit
        end
    end
    
    def confirm_withdraw
    end
    
    def withdraw
        customer = current_customer
        customer.update(is_deleted: true)
        redirect_to destroy_customer_session_path
    end
    
    private
    
    def customer_params
        params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number)
    end
end
