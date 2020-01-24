class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update, :destroy, :update_route_flat]

  # GET /customers
  # GET /customers.json
  def index
    @customers = current_organization.customers.ordered
  end

  # GET /customer/1
  # GET /customer/1.json
  def show; end

  # GET /cusotmers/new
  def new
    @customer = current_organization.customers.new
  end

  # GET /customer/1/edit
  def edit; end

  # POST /customer
  # POST /customer.json
  def create
    @customer = current_organization.customers.new(customer_params)
    @customer.calculate_route_flat!

    respond_to do |format|
      if @customer.save
        format.html { redirect_to edit_customer_path(@customer), notice: 'Kunde wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer/1
  # PATCH/PUT /customer/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to edit_customer_path(@customer), notice: 'Kunde wurde erfolgreich aktualisiert.' }
        format.json { render :show, status: :ok, customer: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer/1
  # DELETE /customer/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_path, notice: 'Kunde wurde erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  def update_route_flat
    @customer.calculate_route_flat!
    @customer.save
    redirect_to edit_customer_path(@customer), notice: 'Wegpauschale wurde aktualisiert.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = current_organization.customers.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(
      :first_name,
      :last_name,
      :street,
      :number,
      :place,
      :zip,
      :route_flat,
      :price_per_hour,
    )
  end

  def current_context
    'customers'
  end
end
