class RequestsController < ApplicationController
    before_action :set_request, only: %i[ show edit update destroy ]
    skip_before_action :is_authorized, only: [:index, :show]

    # GET /requests or /requests.json
    def index
      @requests = Request.all
      render :json => @requests, :include => [:offers, :user]
    end

    # GET /requests/1 or /requests/1.json
    def show
    end

    # GET /requests/new
    def new
      @request = Request.new
    end

    # GET /requests/1/edit
    def edit
    end
    # POST
    def create
      @request = Request.create(request_params)
      @request.budget = @request.budget.round(2)
      @request.save
      respond_to do |format|
        if @request.save
          format.html { redirect_to request_url(@request), notice: "Request was successfully created." }
          format.json { render :show, status: :created, location: @request }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @request.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /requests/1 or /requests/1.json
    def update
      respond_to do |format|
        if @request.update(request_params)
          @request.budget = @request.budget.round(2)
          @request.save
          format.html { redirect_to request_url(@request), notice: "Request was successfully updated." }
          format.json { render :show, status: :ok, location: @request }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @request.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /requests/1 or /requests/1.json
    def destroy
      @request.destroy

      respond_to do |format|
        format.html { redirect_to requests_url, notice: "Request was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_request
        @request = Request.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def request_params
        params.require(:request).permit(:user_id, :title, :location, :time, :description, :budget, :status)
        # refer to the schema which now set the default status as 'Open'
      end
end
