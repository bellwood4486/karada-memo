module ApplicationHelper
  def error_explanation(object_with_errors)
    return if object_with_errors.errors.empty?

    messages = object_with_errors.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div id="error_explanation" class="alert alert-danger" role="alert">
      <ul>
        #{messages}
      </ul>
    </div>
    HTML

    html.html_safe
  end

  def new_note_header_link(bodies)
    if bodies.one?
      path = new_body_note_path(bodies.first)
      remote = false
      link_to fa_icon('edit', text: 'メモする'), path, remote: remote,
              class: 'nav-link btn btn-primary text-light', role: 'button'
    else
      link_to fa_icon('edit', text: 'メモする'), '#bodySelectionsModal', data: { toggle: 'modal' },
              class: 'nav-link btn btn-primary text-light', role: 'button'
    end
  end
end
