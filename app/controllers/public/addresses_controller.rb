class Public::AddressesController < ApplicationController
    
    def create
        @address = Address.new(address_params)
        @address.customer_id = current_customer.id
        if @book.save
            flash[:notice] = "successfully submitted the book!"
        end
        render :index
    end
    
    def index
        @addresses = Address.all
        @address = Address.new
    end
    
    def edit
        @address = Address.find(params[:id])
    end
    
    
    def update
        address = Address.find(params[:id])
        if address.update(address_params)
        flash[:notice] = "successfully edited the address!"
            redirect_to addresses_path
        else
            render :edit
        end
    end
    
    def destroy
        address =Address.find(params[:id])
        if address.destroy
            flash[:notice] = "The address was successfully destroyed."
            render :index
        end
    end
    
    private
    
    def address_params
        params.require(:address).permit(:customer_id, :postal_code, :address, :destination)
    end
end
