// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks

//= require jquery3
//= require turbolinks
//= require bootstrap-sprockets
//= require jquery.raty
//= require ratyrate
//= require cocoon
//= require select2
//= require bootstrap-dialog/src/js/bootstrap-dialog



//= require ./core/core
//= require_tree ./classes

Turbolinks.start();
Application.app = new Application.Core;
Application.app.start();

$(document).ready(function() {
    validation();
    removeArticle();
    checkNicname();

});

function validation() {
    var $titleInput = $("#article_title");

    $titleInput.change( function(event) {
        var $errorTag = $(event.currentTarget).closest('form.new_article').find('p.title-error');
        if($(event.currentTarget).val().length <= 5) {
            $(event.currentTarget).addClass('validation-error');
            $errorTag.removeClass('hidden');
        } else {
            $(event.currentTarget).removeClass('validation-error');
            $errorTag.addClass('hidden');
        }
    });

    $titleInput.focus( function(event) {
        if($(event.currentTarget).hasClass('validation-error')) {
            $(event.currentTarget).addClass('validation-error');
        } else {
            $(event.currentTarget).removeClass('validation-error');
        }
    });
}

function removeArticle() {
    $('.remove-article-btn').on('click', function(event) {

        if(confirm("Are you sure?")) {
            let $articleDiv = $(event.currentTarget).closest('.article');
            let articleId = $articleDiv.data('articleId');
            $.ajax({
                url: '/articles/' + articleId,
                dataType: 'JSON',
                method: 'DELETE'
            })
                .done(function(responce) {
                    console.log( "success", responce );
                    $articleDiv.remove()
                })
                .fail(function(responce) {
                    console.log( "error",  responce);
                });
        }

    })
}

function checkNicname() {
    let timer;
    $('#user_nickname').on('input paste', function (event) {
        clearTimeout(timer);
        if ($(event.currentTarget).val().length ===0){
            $(event.currentTarget).closest('.user_nickname').find('small').remove();
            $(event.currentTarget).removeClass('validation-success');
            $(event.currentTarget).removeClass('validation-error');
            $(event.currentTarget).closest('.user_nickname').append("<small class='form-text text-muted' >this nickname is be unique and can't be blank</small>");
        } else{
            timer = setTimeout(function(){
                $.ajax({
                    url: '/check_nickname',
                    dataType: 'JSON',
                    method: 'POST',
                    data: {nickname: $(event.currentTarget).val() }
                })
                    .done(function(responce) {
                        if(responce.is_exist){
                            $(event.currentTarget).closest('.user_nickname').find('small').remove();
                            $(event.currentTarget).addClass('validation-error');
                            $(event.currentTarget).removeClass('validation-success');
                            $(event.currentTarget).closest('.user_nickname').append('<small class="form-text text-muted text-error" >this nickname is not available</small>');
                        }else {
                            $(event.currentTarget).closest('.user_nickname').find('small').remove();
                            $(event.currentTarget).removeClass('validation-error');
                            $(event.currentTarget).addClass('validation-success');
                            $(event.currentTarget).closest('.user_nickname').append('<small class="form-text text-muted text-success">this nickname is available</small>');
                        }


                        console.log( "success", responce );
                       // $articleDiv.remove()
                    })
                    .fail(function(responce) {
                        console.log( "error",  responce);
                    });

            }, 2000);
        };
    } )
}
