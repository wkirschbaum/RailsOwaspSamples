# app/views/layouts/shared/_header.html.erb

<li style="color: #FFFFFF">
   <!--
    I'm going to use HTML safe because we had some weird stuff
    going on with funny chars and jquery, plus it says safe so I'm guessing
    nothing bad will happen
  -->
  Welcome, <%= current_user.first_name.html_safe %>
</li>

# Similar to this

def raw(dirty_string)
  dirty_string.to_s.html_safe
end

