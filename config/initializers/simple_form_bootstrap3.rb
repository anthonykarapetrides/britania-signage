# http://stackoverflow.com/questions/14972253/simpleform-default-input-class
# https://github.com/plataformatec/simple_form/issues/316
inputs = %w[
CollectionSelectInput
DateTimeInput
GroupedCollectionSelectInput
NumericInput
PasswordInput
RangeInput
StringInput
TextInput
]
inputs.each do |input_type|
  superclass = "SimpleForm::Inputs::#{input_type}".constantize
  new_class = Class.new(superclass) do
    def input_html_classes
      super.push('form-control')
    end
  end
  Object.const_set(input_type, new_class)
end
# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|

  config.boolean_style = :nested

  config.wrappers :bootstrap3, tag: 'div', class: 'form-group', error_class: 'has-error',
                  defaults: { input_html: { class: 'default_class' } } do |b|
    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder
    b.optional :pattern
    b.optional :readonly
    b.use :label_input
    b.use :hint, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
  end

  config.wrappers :bootstrap3_horizontal, tag: 'div', class: 'form-group', error_class: 'has-error',
                  defaults: { input_html: { class: 'default-class'}, :label_html => {:class => 'col-lg-3 col-md-3'}, wrapper_html: { class: "col-lg-9 col-md-9"} } do |b|

    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder

    b.optional :pattern
    b.optional :readonly

    b.use :label#, wrap_with: { tag: 'span', class: 'col-sm-3 control-label' }

    b.wrapper :right_column, tag: :div, class: 'col-lg-9 col-md-9' do |component|
      component.use :input
      component.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      component.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
    end
  end

  config.wrappers :bootstrap3_regular, tag: 'div', class: 'form-group', error_class: 'has-error',
                  defaults: { input_html: { class: 'default-class'} } do |b|

    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder

    b.optional :pattern
    b.optional :readonly

    b.use :label #, wrap_with: { tag: 'span', class: 'col-sm-3 control-label' }

    b.use :input
    b.use :hint, wrap_with: {tag: 'span', class: 'help-block'}
    b.use :error, wrap_with: {tag: 'span', class: 'help-block has-error'}
  end

  config.wrappers :label4div8, tag: 'div', class: 'form-group', error_class: 'has-error',
          defaults: { input_html: { class: 'default-class'}, :label_html => {:class => 'col-lg-4 col-md-4'}, wrapper_html: { class: "col-lg-8 col-md-8"} } do |b|

      b.use :html5
      b.use :min_max
      b.use :maxlength
      b.use :placeholder

      b.optional :pattern
      b.optional :readonly

      b.use :label#, wrap_with: { tag: 'span', class: 'col-sm-3 control-label' }

      b.wrapper :right_column, tag: :div, class: 'col-lg-8 col-md-8' do |component|
          component.use :input
          component.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
              component.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
      end
  end

  config.wrappers :bootstrap3_modal_horizontal, tag: 'div', class: 'form-group', error_class: 'has-error',
                  defaults: { input_html: { class: 'default-class input-sm'}, :label_html => {:class => 'input-sm col-lg-3 col-md-3'}, wrapper_html: { class: "col-lg-9 col-md-9"} } do |b|

    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder

    b.optional :pattern
    b.optional :readonly

    b.use :label, class: 'input-sm col-lg-3 col-md-3' #, wrap_with: { tag: 'span', class: 'col-sm-3 control-label' }

    b.wrapper :right_column, tag: :div, class: 'col-lg-9 col-md-9' do |component|
      component.use :input, class: 'input-sm'
      component.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      component.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
    end
  end

  config.wrappers :group, tag: 'div', class: "form-group", error_class: 'has-error',
                  defaults: { input_html: { class: 'default-class'} }  do |b|

    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder

    b.optional :pattern
    b.optional :readonly

    b.use :label
    b.wrapper :right_column, tag: :div do |component|
      component.use :input, wrap_with: { class: "input-group" }
      component.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      component.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
    end
  end

  config.default_wrapper = :bootstrap3
end