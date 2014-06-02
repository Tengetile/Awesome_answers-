class QuestionsController < ApplicationController
    
    before_action :find_question, only: [:show, :edit, :update, :destroy]

    def index   #index rails name for listing all the questions
      @questions=Question.all
    end

    def new
      @question =Question.new
    end

    def create
      @question = Question.new question_attributes #instiantiate quesiton in memory
      if @question.save
        
        redirect_to questions_path, notice: "Question created successfully"   #redirect if you saved the question correctly
      else 
        #renders a new template if left blank it would have 
        #rendered create as that is the default after the end of this method
        flash.now[:alert]="Problem saving question"
        render :new  
      end       
    end

    def show           #find the entry and show it
    end

    def edit
    end

    def update
      if @question.update_attributes question_attributes
        redirect_to @question, notice: " Question Updated successfully"    #redirect to the show page
        else
          render :edit
      end  
    end

    def destroy
      @question.destroy
      redirect_to questions_path, notice: "Question deleted Successfully"
    end

    

  private

    def find_question
       @question = Question.find params[:id]
    end

    def question_attributes
      params.require(:question).permit(:title, :description)
    end

end
