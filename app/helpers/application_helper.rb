module ApplicationHelper
  def custom_pagy_nav(pagy)
    prev_link = if pagy.prev
      link_to(
        raw("<span class='mr-1 tracking-normal text-white/50 transition-transform group-hover:-translate-x-0.5'>&lt;-</span>#{I18n.t('.previous', default: 'Previous')}"),
        url_for(params.permit!.to_h.merge(page: pagy.prev)),
        class: "btn-sm group relative bg-linear-to-b from-gray-800 to-gray-800/60 bg-[length:100%_100%] bg-[bottom] text-gray-300 before:pointer-events-none before:absolute before:inset-0 before:rounded-[inherit] before:border before:border-transparent before:[background:linear-gradient(to_right,var(--color-gray-800),var(--color-gray-700),var(--color-gray-800))_border-box] before:[mask-composite:exclude_!important] before:[mask:linear-gradient(white_0_0)_padding-box,_linear-gradient(white_0_0)] hover:bg-[length:100%_150%] [&[inert]]:opacity-30"
      )
    else
      tag.span(
        raw("<span class='mr-1 tracking-normal text-white/50'>&lt;-</span>#{I18n.t('.previous', default: 'Previous')}"),
        class: "btn-sm text-gray-600 cursor-not-allowed"
      )
    end

    next_link = if pagy.next
      link_to(
        raw("#{I18n.t('.next', default: 'Next')}<span class='ml-1 tracking-normal text-white/50 transition-transform group-hover:translate-x-0.5'>-&gt;</span>"),
        url_for(params.permit!.to_h.merge(page: pagy.next)),
        class: "btn-sm group relative bg-linear-to-b from-gray-800 to-gray-800/60 bg-[length:100%_100%] bg-[bottom] text-gray-300 before:pointer-events-none before:absolute before:inset-0 before:rounded-[inherit] before:border before:border-transparent before:[background:linear-gradient(to_right,var(--color-gray-800),var(--color-gray-700),var(--color-gray-800))_border-box] before:[mask-composite:exclude_!important] before:[mask:linear-gradient(white_0_0)_padding-box,_linear-gradient(white_0_0)] hover:bg-[length:100%_150%] [&[inert]]:opacity-30"
      )
    else
      tag.span(
        raw("#{I18n.t('.next', default: 'Next')}<span class='ml-1 tracking-normal text-white/50'>-&gt;</span>"),
        class: "btn-sm text-gray-600 cursor-not-allowed"
      )
    end

    tag.nav(class: "mx-auto mt-16 flex max-w-xs items-center justify-between") do
      tag.div { prev_link } +
      tag.div(class: "text-sm text-gray-600") do
        tag.span(pagy.page.to_s, class: "text-gray-200") + " / ".html_safe +
        tag.span(pagy.pages.to_s, class: "text-indigo-200/65")
      end +
      tag.div { next_link }
    end
  end
end
