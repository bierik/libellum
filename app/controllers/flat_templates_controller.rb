class FlatTemplatesController < ApplicationController
  before_action :set_flat_template, only: [:show, :edit, :update, :destroy]

  # GET /flat_templates
  # GET /flat_templates.json
  def index
    @flat_templates = current_organization.flat_templates.ordered
  end

  # GET /flat_templates/1
  # GET /flat_templates/1.json
  def show; end

  # GET /flat_templates/new
  def new
    @flat_template = current_organization.flat_templates.new
  end

  # GET /flat_templates/1/edit
  def edit; end

  # POST /flat_templates
  # POST /flat_templates.json
  def create
    @flat_template = current_organization.flat_templates.new(flat_template_params)

    respond_to do |format|
      if @flat_template.save
        format.html { redirect_to flat_templates_path, notice: 'Pauschalvorlage wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @flat_template }
      else
        format.html { render :new }
        format.json { render json: @flat_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flat_templates/1
  # PATCH/PUT /flat_templates/1.json
  def update
    respond_to do |format|
      if @flat_template.update(flat_template_params)
        format.html { redirect_to flat_templates_path, notice: 'Pauschalvorlage wurde erfolgreich aktualisiert.' }
        format.json { render :show, status: :ok, location: @flat_template }
      else
        format.html { render :edit }
        format.json { render json: @flat_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flat_templates/1
  # DELETE /flat_templates/1.json
  def destroy
    @flat_template.destroy
    respond_to do |format|
      format.html { redirect_to flat_templates_path, notice: 'Pauschalvorlage wurde erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_flat_template
    @flat_template = current_organization.flat_templates.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def flat_template_params
    params.require(:flat_template).permit(:name, :price)
  end

  def current_context
    'flat_templates'
  end

  helper_method :current_context
end
