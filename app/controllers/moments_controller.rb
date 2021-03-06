class MomentsController<ApplicationController

    before_action :ensure_user_is_admin
    def index
        @moments= Moment.all
    end

    def new
        @moment = Moment.new
    end

    def create
        @moment = Moment.new(params.require(:moment).permit(:study_id, :from, :until))
        @moment.save

        render 'show'
    end

    def show
        @moment = Moment.find(params[:id])
    end

    def destroy
        @moment = Moment.find(params[:id])
        @moment.destroy

        redirect_to moments_path
    
    end


    def edit
        @moment = Moment.find(params[:id])
        puts @moment
    end

    def update
        moment_params = params.require(:moment).permit(:id, :study_id, :from, :until)
        @moment = Moment.find(params[:id])
        @moment.update(moment_params)

        render 'show'
    end

    
    
end