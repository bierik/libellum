class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_customer, except: [:update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = if params.key? :customer_id
               current_organization.customers.find(params[:customer_id]).tasks.ordered
             else
               current_organization.tasks.ordered
             end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @customer.tasks.new(
      task_params.merge(organization: current_organization),
    )
    respond_to do |format|
      if @task.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.json { render json: @task, status: :ok }
      else
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = current_organization.tasks.find(params[:id])
  end

  def set_customer
    @customer = current_organization.customers.find(params[:customer_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:title, :datetime, :duration, :frequency)
  end
end
