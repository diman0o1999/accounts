Application.Classes.Favorites = class Favorites {

    constructor($el) {
        this.$favorited =    $el.find('a.favorites');
        this.$notFavorited = $el.find('a.not-favorites');
        this.$setReport = $el.find('a.add-report');
        this.setFavorite();
        this.unsetFavorites();
        this.setReport();
    }


    setFavorite() {
        this.$notFavorited.on('click', (event) => {
            let $articleDiv = $(event.currentTarget).closest('.article');
            let articleId = $articleDiv.data('articleId');
            $.ajax({
                url:      `/articles/${articleId}/add_to_favorites`,
                dataType: 'JSON',
                method:   'PUT',
                headers: {
                    'X-CSRF-Token': gon.csrf_token
                }
            }).then(() => {
                this.toggleButton($(event.currentTarget));
            }).catch((error) => {
                console.log('setFavorite -> error', error);
            });
        });
    }


    unsetFavorites() {
        this.$favorited.on('click', (event) => {
            let $articleDiv = $(event.currentTarget).closest('.article');
            let articleId = $articleDiv.data('articleId');
            $.ajax({
                url:      `/articles/${articleId}/delete_from_favorites`,
                dataType: 'JSON',
                method:   'PUT',
                headers: {
                    'X-CSRF-Token': gon.csrf_token
                }
            }).then(() => {
                this.toggleButton($(event.currentTarget));
            }).catch((error) => {
                console.log('unsetFavorites -> error', error);
            });

        });
    }


    toggleButton(button) {
        $(button).closest('section').find('a.fvr-btn').toggleClass('hidden');
    }


    setReport() {
        this.$setReport.on('click', (event) => {
            let $articleDiv = $(event.currentTarget).closest('.article');
             let articleId = $articleDiv.data('articleId');
            let categoryId = $articleDiv.find('i.glyphicon-folder-open').attr('categoryId');
            console.log($articleDiv.find('h4').text());
            $('#titel-report').text(`Вы выбрали пост о  ${$articleDiv.find('h4').text()}`);
            $('.myModal').on('shown.bs.modal', function () {

            })
        });


        $( ".reported-type" ).on( "click",(event)=>{
                if($(event.currentTarget).val()==4){
                    $('#textarea').prop('disabled',false);
                }else {
                    $('#textarea').prop('disabled',true);
                }
        });
        $('#submit-report').on('click',(event)=>{
            $.ajax({
                url:      '/reports',
                dataType: 'JSON',
                method:   'POST',
                data: {
                    report: {
                        'article': 0,
                        'category': $(event.currentTarget).val(),
                        'body': $('#textarea').text()
                    }},
                headers: {
                    'X-CSRF-Token': gon.csrf_token
                }
            }).then(() => {
                this.toggleButton($(event.currentTarget));
            }).catch((error) => {
                console.log('setFavorite -> error', error);
            });
        });


    }



};