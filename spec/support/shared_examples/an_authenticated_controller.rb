# An authenticated controller
# tests invocation of the Devise before_filter :authenticate_user!
#
# it_should_behave_like "an authenticated controller", {
#   index: [:get],
#   show: [:get, id: 1],
#   new: [:get],
#   edit: [:get, id: 1],
#   create: [:post],
#   update: [:put, id: 1],
#   destroy: [:delete, id: 1]
# }
#
shared_examples_for "an authenticated controller" do |actions|
  actions.each do |action, (verb, options)|
    docstring = "#{ verb.upcase } ##{ action }"
    docstring << " with #{ options }" if options

    describe docstring do
      before { send(verb, action, options) }
      it_should_behave_like "an authenticated controller action"
    end
  end
end
