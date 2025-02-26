class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    a = Actor.new
    a.bio = params.fetch("query_bio")
    a.dob = params.fetch("query_dob")
    a.image = params.fetch("query_image")
    a.name = params.fetch("query_name")
    a.save

    redirect_to("/actors")
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_records = Actor.where({ :id => the_id })
    the_actor = matching_records.at(0)
    the_actor.destroy
    redirect_to("/actors")
  end

  def modify
    the_id = params.fetch("an_id")
    matching_records = Actor.where({ :id => the_id })
    a = matching_records.at(0)
    a.bio = params.fetch("query_bio")
    a.dob = params.fetch("query_dob")
    a.image = params.fetch("query_image")
    a.name = params.fetch("query_name")
    a.save

    redirect_to("/actors/#{a.id}")
  end

end
