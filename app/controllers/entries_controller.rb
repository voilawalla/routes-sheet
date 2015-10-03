# route for entries index
# erb view/ crud action: index
get '/entries' do
  @entries = Entry.all
end

# route for displaying form for new entries
# erb view/ crud action
get '/entries/new' do
  @entry = Entry.new
end
# the reason that we pass a blank entry when first rendering the new entry form in /entries/new is so we can do error handling in the post for creating a new entry (post "/entries").



# route for showing an entry
# erb view/ crud action:
get '/entries/:id' do
  @entry = Entry.find_by(id: params[:id])
  # the difference between find and find_by in ActiveRecord is that find will raise an ActiveRecord Error: Record not found if it cannot find the thing, but find_by(attribute: value) will return nil if it does not find anything
end

# route to create new entries
post '/entries' do
  @entry = Entry.new(title: params[:title], body: params[:body])
  if @entry.save
    redirect '/entries'
  else
    erb :"entries/new"
  end
end
 # The error handling is pretty much done in the view, what we do in the route is just say if the entry does not save, re render the new form. In that form, @entry.errors refers to the errors array that is automatically added to every ActiveRecord object. that errors array has a method full_messages that returns a hash with errors as keys and messages as values. Basically, by saying @entry.errors.full_messages.each do |message|, we are saying for every error message on that object, we are going to print the message



# route to display form to edit an entry
# erb view / crud action: edit
# you should always PREFILL the values for your forms in edit forms. value="<%= @entry.title %>"
get '/entries/:id/edit' do
  @entry = Entry.find_by(id: params[:id])
end


# route to edit entries
# in your form do not forget the method override!
put '/entries/:id' do
  @entry = Entry.find_by(id: params[:id])
  @entry.update_attributes(title: params[:title], body: params[:body])
  if entry.valid?
    redirect '/entries'
  else
    erb :"entries/edit"
  end
end



# route to delete entries
delete '/entries/:id' do
  @entry = Entry.destroy(params[:id])
end

# matt thoughts

# important things to take away:
# :id in the route indicates that whatever comes after that / in the route will be treated as a param and added to the params hash
# watch out for conflicting routes in your new and id routes. if you do not put them in the correct order in the file then in /entries/new, the /new part will be treated as a variable
# @entry.id == params[:id] #returns false because params[:id]
# if you are pulling params from forms, the way it is accessed depends upon the name field in the form. For instance, in the new.erb form, to pull out the information for the title value params[:title]
# if you are assigning a label for something, the for= must be the same as the input id=


