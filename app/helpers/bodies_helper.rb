module BodiesHelper
  def body_select_tag(bodies, options = {})
    select_tag(:bodySelection,
               options_for_select(body_options(bodies)),
               options)
  end

  def body_options(bodies)
    bodies.map { |b| [b.nickname, new_body_note_path(b)] }
  end
end
