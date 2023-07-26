class Public::CustomersController < ApplicationController
  def show
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customer_path(@customer)
  end

  def confirm
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    if @customer.update(is_deleted: true)
      reset_session
      redirect_to root_path
    else
      redirect_to confirm_customer_path
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
