$(document).ready(() ->
  $('#organization_category').autocomplete({
                                           source: (req, add) ->
                                             $.ajax
                                               type: "POST"
                                               url: "/organizations/autocomplete_categories"
                                               data:
                                                 "name": $("#organization_category").val(),
                                                 "country_code_id": $("#country_code_id").val()
                                               dataType: "json"
                                               success:(data) ->
                                                 add(data);
                                           ,
                                           select: (event, ui) ->
                                             $("#organization_category_id").val(ui.item.id);
                                           });

  $(document).on('click', '#new_organization_save', () ->
    form = $('#new_organization');
    if (new_organization_validate(form))
      $('#flash-notice').empty();
    else
      return false;
  )
  $(document).on('click', '#md-organization .btn-save', () ->                                
    form = $('#new_organization');
    tag_btn = $(this)
    if (new_organization_validate(form)) 
      $('#flash-notice').empty();
      $.ajax
        type: "POST"
        url: "/organizations"
        data:
          "organization[name]": form.find('input[name="organization[name]"]').val()
          "organization[street]": form.find('input[name="organization[street]"]').val()
          "organization[street2]": form.find('input[name="organization[street2]"]').val()
          "organization[postalcode]": form.find('input[name="organization[postalcode]"]').val()
          "organization[state]": form.find('input[name="organization[state]"]').val()
          "organization[phone1]": form.find('input[name="organization[phone1]"]').val()
          "organization[phone2]": form.find('input[name="organization[phone2]"]').val()
          "organization[country_code_id]": form.find('select[name="country_code_id"]').val()
          "organization[city]": form.find('input[name="organization[city]"]').val()
          "organization[category_id]": form.find('input[name="organization[category_id]"]').val()
          "organization[url]": form.find('input[name="organization[url]"]').val()
        dataType: "json"
        beforeSend: () ->
          tag_btn.hide()
          tag_btn.parent().append('<img src="/assets/loading.gif" style="margin: 6px 53px 6px 52px"/>')
        success:(response) ->
          $('.modal-backdrop').click()
          $('#list-venues').append(response.data)
          console.log(response.data)
        error: (response) ->
          tag_btn.show()
          $('#flash-notice').empty().show().html('<div>Having problem when create organization</div>');
    else
      return false;
  )

  new_organization_validate = (form) ->
    form.validate({
      errorLabelContainer: $('#flash-notice'),
      errorElement: "p",
      rules:
        "organization[name]":
          required: true
        "organization[street]":
          required: true
        "organization[postalcode]":
          required: true
        "organization[phone1]":
          required: true
          phonenumber: true
        "city_name":
          required: true
        'organization[category_id]':
          required: true
      messages:
        "organization[name]":
          required: "Field Name is required."
        "organization[street]":
          required: "Field Street is required."
        "organization[postalcode]":
          required: "Field Postal Code is required."
        "organization[phone1]":
          required: "Field Phone is required."
          phonenumber: "Field Phone Number is invaild."
        "city_name":
          required: "Field City is required"
        "organization[category_id]":
          required: "Field Category is required."
    })

    return form.valid();
);