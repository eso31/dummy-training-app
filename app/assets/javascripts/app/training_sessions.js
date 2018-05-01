(function ($, App) {
  "use strict";

  $(document).on("turbolinks:load", function () {
    var courseDataToOptions = function (value, i) {
      return {id: value.id, text: value.title}
    };

    var classLocationDataToOptions = function (value, i) {
      return {id: value.id, text: value.name}
    };

    var userDataToOptions = function (value, i) {
      return {id: value.id, text: value.to_s}
    };

    if ($('.training_sessions.new,.training_sessions.edit').length) {
      Autocomplete.setup('course', Routes.courses_path(), courseDataToOptions);
      Autocomplete.setup('class_location', Routes.class_locations_path(), classLocationDataToOptions);
      Autocomplete.setup('instructors', Routes.users_path(), userDataToOptions);
    }

    if ($('.training_sessions.show').length) {
      Autocomplete.setup('user', Routes.enrollment_users_path(), userDataToOptions);
    }

    //function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}
    $('.published-status').change(function(){
      $.ajax({
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        url: Routes.training_session_path($(this).data('ts')),
        type: 'PUT',
        dataType: "json",
        data: {
          training_session: {
            published: $(this).val()
          }
        }
      });
    });

      // Callback after attended check
      $(".attend-check").on("ajax:success", function () {
        var row = $(this).parent().parent();
        var stars_container = row.find('td').eq(3);
        var rating = $(this).data('session-rating');
        var own_enrollment = $(this).data('own-enrollment');

        // Clear the stars
        stars_container.html('');

        // Show or hide the stars rating
        if($(this).is(':checked')) {
          for (var i = 0; i < 5; i++) {
            stars_container.append(star_template(i < rating, own_enrollment, i+1))
          }
        } else {
          // In this moment the session rating was deleted

          // Clear rating data
          $(this).data('session-rating', 0);

          // And clear modal form
          var session_rating_form = $('#ratingModal').find('form');

          // Clear inputs in form
          session_rating_form.find('input[type="text"], textarea').val('');
          session_rating_form.attr('action', Routes.session_ratings_path());
          session_rating_form.find('input[name="_method"]').remove();
          session_rating_form.find('.btn').val('Create session rating');
        }
      });

      // Modal load data
      $('#ratingModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Button that triggered the modal
        var rating = button.data('rating'); // Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this);
        modal.find('input[name="session_rating[rating]"]').val(rating);
      });

        // Print the window
        $('#print-button').click(function () {
            window.print();
        });


        //Script for loading datetimepickers
      $(".form_datetime").datetimepicker({
          format: 'yyyy-mm-dd HH:ii',
          showMeridian: true,
          todayBtn: true,
          autoClose: true
      });
    });

  /**
   * Create a new HTML string for rating star
   * @param filled: Boolean who represents if the star is filled
   * @param clickable: Boolean who represents if the star correspond to a link to rate
   * @param rate: Rate of the star */
  function star_template(filled, clickable, rate) {
    var result = '<i class="fa fa-star' + (filled ? '' : '-o') + '"></i>';

    if(clickable){
      result = '<a href="#" data-toggle="modal" data-target="#ratingModal" data-rating="' + rate + '" >'
      + result + '</a>'
    }

    return result;
  }
})(jQuery, Autocomplete);